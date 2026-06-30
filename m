Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE583FBEC1
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823604; cv=none; b=hPjJNB93tLMC/Hn2QBkvA2+eHp7M94Dm1M5tSAKHdpWBEUZdas/BCZnOTqn6N1woRDWKOnm0XUTqYqKxYKDbHDsoqZ5ZXd99wlCbRE1pcWU06doXyMdNhtMMsVnt/8Q3QXlTCJVabjaeP0v5jW6ML7MCOV1ChON8YXeRZQULJoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823604; c=relaxed/simple;
	bh=PxqKtpx3FyLpZNRYpTr7hcZOV7MsKvNIU9b44l4suLU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Mc9OOoYzRwDPgkgPNymwESKpIORXaxlmd3XSwdEwsmGvHFyMlbZVyc0oMjlI3Uuy0dCPzoNRtVkbXPmhLSasjM9ajT2Yn4keEml7I4HD3QNvj7Gfq074otqzSHjVZOZTkA9e9D2Whzo8XpAvcF29brvWWek0ZRr9k7qhZXrEE6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=IubpzA3+; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="IubpzA3+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782823599; bh=NlISi6Rp/uuCxNnD2Etwb/tWLq6Cin3Mm/X4skjvR7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IubpzA3+wpiV2AIPx+fqM9pd0IzehOjvUG3lHnHF9t6BBNnHs7V0PALdmspVsQBqz
	 1tiVfMv3futg6HRDj3YOSbIQ72yz1T8kOctugQ8yDRoXga/aHO8BttppyEWAOBV7Eq
	 1No0HRAcNOZVhHpEMc1K26TTyUmIlbw9H8MYknsc=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id BA4B2CE7; Tue, 30 Jun 2026 20:46:36 +0800
X-QQ-mid: xmsmtpt1782823596tj0y34xgz
Message-ID: <tencent_B6259ABAF5BB63335B9E3C1BB74B071BD608@qq.com>
X-QQ-XMAILINFO: Nj+lDvaLCxoMXhcko6wIWnPCjB0eSfVRTB26+OCAW/vdXE5lbw1ou9JGeaMq19
	 7MgHJKDPvitT5i1NFKrIhLbYH2x+yyOvQV2UrOoxcGfKX1gyVTm8bwx/ILeRd3kRZRzOdLotGfLU
	 qrD3ZL1o+7Ob96EXX9KgV3xmKQv1C2FWGRxKUrrINmeXQ3XBN3IvWp2KvLBBoRdpLkCxTKyUyTWB
	 Q5zq3ZRhdHnHVKjxRvh5az/op2DNTKqbjaS97nSA9o/HsUid7fwF/p0H/Ww8yDaSSdcHQ2jixiIA
	 7IhlIzqNL6ogmHT0f4QbBDObpdFbbWl7dXophKAdlgWi6QP9+ccy6DalTmseCnraK1XXodTxFP/h
	 j2/vBH2ORcohThCIafP4j3Afu82g8XUYEG2ezIQsm/p29QA8NXj+qh+veH3h5SnZ617Ag3hFj2Vm
	 6yBJhva4XCtE31V82v5f7VWaPMiyhfHQqQvUjwi1bVnl8MzXaVkhHv4ybOrISyvT45zgPwODFpyj
	 83GXtJMIsTFovdUBNG0dFa3HFArdbdM86hHNAP6dqTK7/ECO6YZv2OSUYks2XA1aOtIO3+G4/EWh
	 qnJkaPcghECr14SSJVpmugleRAmmYoII64w9nRUvcEWOg4a16l1WrBczRGNbqZ7sgBqXeET/QTBN
	 GZw7rNhUTrpasr1A1dL6vuKenDoXAJaizdkL6BwfzzD0x4cJVjtvcty0JALPoRvVPzNyxuJOgo+K
	 jjf21PZBv1V0QPFRkAYDVOeP2Ts68f2liZw0ZZ6aDgaVN5aVmVImUv7pmdDDt1fIY2vinDo8K0J5
	 Ma7xAJzaaBIEZHkTwdevM19HpdGps22ltoiUGxv2YJbuHUUPOj4WfaipGsYfrSb9Bc9TrqqwSiOP
	 /gxsB5CqeZ5rKeOV2aGtRj19Hi4ulLz6df/X+Ygf9vyKEIdB63962sYXr6FAm6rM1F38mM4Cuaxk
	 LkVabudPNmRuuS4ixYSfh7osDTl2ohEEvjbT7ZmmVnicZ61gaF94WgoNPzJKngr/nte5NQzUn+Ur
	 Bk6HLC8KQhOe34nx12ojNZ/Cs/JlQ=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Edward Adam Davis <eadavis@qq.com>
To: jiayuan.chen@linux.dev
Cc: bpf@vger.kernel.org,
	eadavis@qq.com,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2] bpf: Fix smp_processor_id() call trace for preemptible kernels
Date: Tue, 30 Jun 2026 20:46:37 +0800
X-OQ-MSGID: <20260630124636.953001-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f72ebb75-66e8-47ae-b1f0-e77d6a24f3e0@linux.dev>
References: <f72ebb75-66e8-47ae-b1f0-e77d6a24f3e0@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Jun 2026 20:25:30 +0800, Jiayuan Chen wrote:
>On 6/30/26 7:14 PM, Edward Adam Davis wrote:
>> On Tue, 30 Jun 2026 09:48:23 +0000, Sashiko wrote:
>>> [Severity: High]
>>> Does this fix the issue at the right layer? By adding the preemption
>>> protection here, it masks the fact that the caller is running with migration
>>> enabled, which leaves sibling APIs vulnerable.
>>>
>>> For example, in __rhtab_map_lookup_and_delete_batch() in
>>> kernel/bpf/hashtab.c, the batch loop iterates and calls rhtab_delete_elem()
>>> without disabling migration.
>>>
>>> If the map elements contain special fields (like BPF_KPTR),
>>> rhtab_delete_elem() will first call rhtab_check_and_free_fields(), which
>>> eventually calls bpf_mem_free().
>>>
>>> Since bpf_mem_free() also uses this_cpu_ptr() without get_cpu() protection:
>>>
>>> kernel/bpf/memalloc.c:bpf_mem_free() {
>>>      ...
>>>      unit_free(this_cpu_ptr(ma->caches)->cache + idx, ptr);
>>>      ...
>>> }
>>>
>>> Will this result in the exact same BUG being triggered on that path? Should
>>> the missing migration protection be added to
>>> __rhtab_map_lookup_and_delete_batch() instead of modifying the allocator
>>> here?
>> Like this?
>>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 9f394e1aa2e8..7b98c2eea685 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -3345,8 +3345,10 @@ static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
>>   	}
>>
>>   	if (do_delete) {
>> +		get_cpu();
>>   		for (i = 0; i < total; i++)
>>   			rhtab_delete_elem(rhtab, del_elems[i], NULL, 0);
>> +		put_cpu();
>>   	}
>>
>>   	rcu_read_unlock();
>
>
>This splat is specific to rhash...
>
>For HASH/PERCPU_HASH/..., most operations are performed under
>bpf_disable_instrumentation(); see __htab_map_lookup_and_delete_batch().
>
>But for rhash, bpf_mem_cache_free_rcu() is called outside the
>bpf_disable_instrumentation() region; see
>__rhtab_map_lookup_and_delete_batch().
Let's use bpf_disable/enable_instrumentation() consistently to protect
__rhtab_map_lookup_and_delete_batch().

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 9f394e1aa2e8..d3f2f8a379e8 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -3299,6 +3299,7 @@ static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
 	dst_val = values;
 	total = 0;
 
+	bpf_disable_instrumentation();
 	rcu_read_lock();
 
 	/*
@@ -3313,6 +3314,7 @@ static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
 		elem = rhtab_lookup_elem(map, cursor);
 		if (!elem) {
 			rcu_read_unlock();
+			bpf_enable_instrumentation();
 			ret = -EAGAIN;
 			goto free;
 		}
@@ -3350,6 +3352,7 @@ static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
 	}
 
 	rcu_read_unlock();
+	bpf_enable_instrumentation();
 
 	if (total == 0) {
 		ret = -ENOENT;

