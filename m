Received: from mta1.migadu.com (out-155.mta1.migadu.com [95.215.58.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34854C9573
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793723; cv=none; b=Ofl9fePlbgSKynV7NRo7knKpTY20Wq8yBmIaVvotG7tr+ZetsrP6qfKiCsKzokTpqzfiYqjJSxcfiv1WLwNPMsQU2uPnbOkfdd1iZvCxar3Qg+kzsX7Fpu458VrHcVcIcADY6xFzPgBSITtOIhGTtevPbv5j0Yr5siPrEFRn4ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793723; c=relaxed/simple;
	bh=9IaJRo/onH+WZUAxCRicEOSEY53Kz1vfjpyJNhUkVW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6URe3PZ+29oanWvnpNiOBvkP5IARODLJUax7lXG68g/KVSGZrHatfSC4wDbjceV9od/YNh4joiYiQ6A0tccXyz6CgesY1VTEeyMbE5FZ7WCngeUNz8rEqePqWkOeecVE83LnhCaLZ5i1KYNG0D/Hr8pZ8S9Uf5lQZzdoADZ+io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JNwKlzcd; arc=none smtp.client-ip=95.215.58.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JNwKlzcd"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9IaJRo/onH+WZUAxCRicEOSEY53Kz1vfjpyJNhUkVW4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788793719; v=1; x=1789398519;
 b=JNwKlzcdbuTin8fwQdweSsro1lrTw4XdeHAToOEAr5drnMDbZucvdgT6gaLwq5zX94qZppbi
 GUP58PSlT7HymSAa4fZociirYirjufE2ako1hTjDd3+l35uGnG+avo3NGtm8UIqceSdT41DpqDQ
 uE5xOhmy0LO7TL72wRe6ozws=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9e0dbadcb7e0ce26;
	Mon, 07 Sep 2026 15:08:39 +0000
X-Mizu-Trace-ID: 9e0dbadcb7e0ce26
X-Migadu-Flow: FLOW_OUT
Message-ID: <a44630a1-4965-4020-afb9-ba5b1a7848e6@linux.dev>
Date: Mon, 7 Sep 2026 23:08:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 1/2] bpf: Validate program attach type during
 link update
To: bot+bpf-ci@kernel.org, sanghyun.park.cnu@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, bpf@vger.kernel.org
Cc: john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, sdf@fomichev.me,
 pulehui@huawei.com, suchitkarunakaran@gmail.com, xukuohai@huawei.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20260907015003.65087-2-sanghyun.park.cnu@gmail.com>
 <514a0c26ff5e0322fe0442d07142cafc7dda338a3ce2c5b7e9437dd994cb0ba1@mail.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <514a0c26ff5e0322fe0442d07142cafc7dda338a3ce2c5b7e9437dd994cb0ba1@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/9/7 10:36, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index c7bc9ba9b331..b394a37eecb4 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -4481,14 +4481,9 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
>>  	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
>>  	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
>>  	case BPF_PROG_TYPE_SK_LOOKUP:
>> +	case BPF_PROG_TYPE_LSM:
>>  		return attach_type == prog->expected_attach_type ? 0 : -EINVAL;
> 
> Does adding BPF_PROG_TYPE_LSM to this arm also relax the check on the
> BPF_LINK_CREATE path?
> 
> Before this patch, BPF_PROG_TYPE_LSM fell into the default arm:
> 
> 	default:
> 		ptype = attach_type_to_prog_type(attach_type);
> 		if (ptype == BPF_PROG_TYPE_UNSPEC || ptype != prog->type)
> 			return -EINVAL;
> 		return 0;
> 
> Since attach_type_to_prog_type() returns BPF_PROG_TYPE_LSM only for
> BPF_LSM_MAC and BPF_LSM_CGROUP (kernel/bpf/syscall.c:4457, 4463), an LSM
> program could only ever be accepted for those two attach types.
> 
> The new arm drops that constraint and accepts any attach_type as long as it
> equals prog->expected_attach_type. The other members of that arm are safe
> because bpf_prog_load_check_attach() restricts their expected_attach_type
> to a set that all maps back to the same prog type. BPF_PROG_TYPE_LSM is the
> one type in that arm with no such restriction: bpf_prog_load_check_attach()
> (kernel/bpf/syscall.c:2766 onwards) has no LSM case and falls into
> `default: return 0`, so prog->expected_attach_type is entirely
> userspace-controlled for LSM programs.


Good catch.

Since there's no expected_attach_type check for lsm prog, a lsm prog can
have BPF_TRACE_ITER expected_attach_type, and creates a lsm link via
BPF_LINK_CREATE with this patch. Such lsm prog cannot create a lsm link
via BPF_LINK_CREATE without this patch.

The new case BPF_PROG_TYPE_LSM in bpf_prog_attach_check_attach_type()
relaxes the prog->type check when adding expected_attach_type check.

I think we can add expected_attach_type check for lsm prog in
bpf_prog_load_check_attach(). See below diff. The diff will restrict a
lsm prog with these two expected_attach_type, BPF_LSM_MAC and
BPF_LSM_CGROUP.

Thanks,
Leon

---

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6874ba1424af..4b56e82ff3b9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2830,6 +2830,16 @@ bpf_prog_load_check_attach(enum bpf_prog_type
prog_type,
 		if (expected_attach_type == BPF_NETFILTER)
 			return 0;
 		return -EINVAL;
+	case BPF_PROG_TYPE_LSM:
+		switch (expected_attach_type) {
+		case BPF_LSM_MAC:
+		case BPF_LSM_CGROUP:
+			return 0;
+		default:
+			return -EINVAL;
+		}
 	case BPF_PROG_TYPE_SYSCALL:
 	case BPF_PROG_TYPE_EXT:
 		if (expected_attach_type)

> [...]

