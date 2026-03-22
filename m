Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFFC2773EE
	for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774142442; cv=none; b=ZJk+rJ8Uo+dd3IZ/gaG0RGtp5RuxZ7J5Crb2GiSi2lQeIOJPIBjtCB3vIuzVGY4HdLpzIbG58KIQ0Jg0tSf57GwLkfC4WHEuobMD4Wp4x7ernHHrUQbRVfndZNlZmIib2ol+WOLljiLbcf77X6pZBerYejE0HXwYta97R0QFyGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774142442; c=relaxed/simple;
	bh=YC7qUvr1E4ECRZ6uECeSY381mj4OkAUb+a4ih53vA8A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SlD4alZFV9/xstQUA6cRHBTZ5raxYDpNj3xM09E7SwpD2AGFV55Q5RtnpZqwdgleTPVZzc/hd6BmXq2HQVgDtZ6f/2UiZqsbK+ybUhOar5NrjFzhE7pnZOZk5al+76f+r9le+ij3Vfr1S9Ex5oIH85QvPqxqEMxuKRRv0NSz2W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=11DtnhF1; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="11DtnhF1"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506251815a3so26896131cf.0
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 18:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1774142440; x=1774747240; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2lYegb3d1WlAShOCbB85z2jt2u6c/ceLqqA07OncCc=;
        b=11DtnhF1ixQ+H7b/48zMaeNtR4DqdGo4QkLQ3T45oZ3RVV7C0Gusx4Chz7+uX+eKvj
         PAwb8qY0exECiYEEcGieYuwD8StM5QJckeBUkzf89irj71vHi1uQG/LGT7IMZe0AZOkB
         40B87I+WsQe7MfJPQUxSJJEyargUkfPMlrA/l53TlyXiv4X4JF1IhuWun9MI+oX0jliq
         VtTCZYmN19VOzFkG0x31gLNeJ0sHrrA5izJ1vErk/jvyp20Z46AgfGBAyTO5umSzaoaN
         qVEeKsQ7ihDpJccs4riY2vABEKU8dzzaC85CKygSRfAFeLrC+gSqcxwojUJy/3Pzvff9
         i9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774142440; x=1774747240;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2lYegb3d1WlAShOCbB85z2jt2u6c/ceLqqA07OncCc=;
        b=Vdi1YcEdcqFalZB03/LabzVmuZFBUOfKhAxn6mA6gdjsCwEM4QMIVRCWOKhYGgKpBw
         HNlUvkiMoCOz4gRs7JIgl0nM/9sSDGpsbGB/YbsRz+lcA9fMcGf+OMvBme63Qzq9EMJz
         aZo94VC4bmhEM+CSIQpV/6yMczmc1smP75aEHszXdpHMHJAXiix5sJdl1Y3ZaCrOWU3V
         L+IctnXCCwWWjlAD+52R3rFpxyEVAAc+Pp4ikbZoLG/8fUqrPPPsJWbxSII6ZRAKBuGt
         UeJ3gXpFDI00geEkE02Q9Prh9CiWZaHsO4OlwAeo+wlwmun1Kozi9QIYWiFDg+J/Cm3H
         MTYA==
X-Gm-Message-State: AOJu0YxVKIrBFNkKFl8i3qoFRhrfc2eoqQcPjoTrUed0LDkQVweve6ml
	UrHcR4W6803A4zwqnDWwnnk2dR5DFKIoXUPc+ii1ve02Xf/OD/uMGYFMr6LelEKQhn4=
X-Gm-Gg: ATEYQzwdl5GMAqSHrHfWTN8xedySClkFYsHKBSENN0F7L7oopjybhNZabWA2XfKzzFJ
	uNi9+TFGqO/PYRmRMIKnY68LcS/ug7os+AoI/Gp9/qAxAP/nOaMchQfPH69V7ZQTVP5V30PwxnE
	YVYf6HRFkEKYe1ZqSkg9rpFFf21oFGU7Pi1pDfI5gkgZi78H3Tk2RdEJ2H6ceOmwk2wtSUJpp6U
	1b8uwBsCzlROs8hP6NXq7Lv5uOrbWCeTHdmxMv/9lxo+fNC2EBm+7AoWjDO7zJ7y+Fh468eWwNz
	sAa827IuXxHuJUwjti7lzR3xW8Fg6TNzcEEzqMO2wwk6LDb/yOaR3bXQB+hmA+Z+4XWXIzZj/li
	Hb+zO0rjo9TNFGO+FWezAtj7bBRNVZvNbty0S90ziSRuiIf4SkXKb5g1n/GEEQoolfcqmy3BeKf
	lyAf/AmpfHZtmTXMKpM0lfOd9OFuSxLVv9sQ==
X-Received: by 2002:a05:622a:6097:b0:509:1ee2:69e4 with SMTP id d75a77b69052e-50b3739fe9fmr124931621cf.11.1774142439962;
        Sat, 21 Mar 2026 18:20:39 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36eb54cfsm53223781cf.30.2026.03.21.18.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 18:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Mar 2026 21:20:37 -0400
Message-Id: <DH8X08EB6T7J.2IA6WKFSZ8XGF@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v8 7/8] bpf: add bpf_list_is_first/last/empty
 kfuncs
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, "Chengkaitao"
 <pilgrimtao@gmail.com>, <martin.lau@linux.dev>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
 <kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
 <jolsa@kernel.org>, <shuah@kernel.org>, <chengkaitao@kylinos.cn>,
 <linux-kselftest@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260316112843.78657-1-pilgrimtao@gmail.com>
 <20260316112843.78657-8-pilgrimtao@gmail.com>
 <DH8WLC5587BJ.30X22578QBN3C@etsalapatis.com>
In-Reply-To: <DH8WLC5587BJ.30X22578QBN3C@etsalapatis.com>

On Sat Mar 21, 2026 at 9:01 PM EDT, Emil Tsalapatis wrote:
> On Mon Mar 16, 2026 at 7:28 AM EDT, Chengkaitao wrote:
>> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>>
>> Add three kfuncs for BPF linked list queries:
>> - bpf_list_is_first(head, node): true if node is the first in the list.
>> - bpf_list_is_last(head, node): true if node is the last in the list.
>> - bpf_list_empty(head): true if the list has no entries.
>>
>> Currently, without these kfuncs, to implement the above functionality
>> it is necessary to first call bpf_list_pop_front/back to retrieve the
>> first or last node before checking whether the passed-in node was the
>> first or last one. After the check, the node had to be pushed back into
>> the list using bpf_list_push_front/back, which was very inefficient.
>>
>> Now, with the bpf_list_is_first/last/empty kfuncs, we can directly
>> check whether a node is the first, last, or whether the list is empty,
>> without having to first retrieve the node.
>
> Do you need to expand the exceptions you added in patch 5 for non-owning
> reference arguments to also hold for this? Checking the selftests, we
> don't have one where either bpf_list_is_last or bpf_list_is_first
> return true, can you add one?
>

I misread the selftests, my bad. The tests pass fine, and we just have
to keep an owning reference of the nodes around to pass to the helpers.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>>
>> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
>> ---
>>  kernel/bpf/helpers.c  | 38 ++++++++++++++++++++++++++++++++++++++
>>  kernel/bpf/verifier.c | 11 +++++++++++
>>  2 files changed, 49 insertions(+)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index dc4f8b4eec01..da70dcff4ba8 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2518,6 +2518,41 @@ __bpf_kfunc struct bpf_list_node *bpf_list_back(s=
truct bpf_list_head *head)
>>  	return (struct bpf_list_node *)h->prev;
>>  }
>> =20
>> +__bpf_kfunc bool bpf_list_is_first(struct bpf_list_head *head, struct b=
pf_list_node *node)
>> +{
>> +	struct list_head *h =3D (struct list_head *)head;
>> +	struct bpf_list_node_kern *kn =3D (struct bpf_list_node_kern *)node;
>> +
>> +	if (READ_ONCE(kn->owner) !=3D head)
>> +		return false;
>> +
>> +	return list_is_first(&kn->list_head, h);
>> +}
>> +
>> +__bpf_kfunc bool bpf_list_is_last(struct bpf_list_head *head, struct bp=
f_list_node *node)
>> +{
>> +	struct list_head *h =3D (struct list_head *)head;
>> +	struct bpf_list_node_kern *kn =3D (struct bpf_list_node_kern *)node;
>> +
>> +	if (READ_ONCE(kn->owner) !=3D head)
>> +		return false;
>> +
>> +	return list_is_last(&kn->list_head, h);
>> +}
>> +
>> +__bpf_kfunc bool bpf_list_empty(struct bpf_list_head *head)
>> +{
>> +	struct list_head *h =3D (struct list_head *)head;
>> +
>> +	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
>> +	 * called on its fields, so init here
>> +	 */
>> +	if (unlikely(!h->next))
>> +		INIT_LIST_HEAD(h);
>> +
>> +	return list_empty(h);
>> +}
>> +
>>  __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *r=
oot,
>>  						  struct bpf_rb_node *node)
>>  {
>> @@ -4588,6 +4623,9 @@ BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_R=
ET_NULL)
>>  BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
>>  BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
>>  BTF_ID_FLAGS(func, bpf_list_add_impl)
>> +BTF_ID_FLAGS(func, bpf_list_is_first)
>> +BTF_ID_FLAGS(func, bpf_list_is_last)
>> +BTF_ID_FLAGS(func, bpf_list_empty)
>>  BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
>>  BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
>>  BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 0a6f2e6a5d28..c2cc622bb3a1 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -12512,6 +12512,9 @@ enum special_kfunc_type {
>>  	KF_bpf_list_del,
>>  	KF_bpf_list_front,
>>  	KF_bpf_list_back,
>> +	KF_bpf_list_is_first,
>> +	KF_bpf_list_is_last,
>> +	KF_bpf_list_empty,
>>  	KF_bpf_cast_to_kern_ctx,
>>  	KF_bpf_rdonly_cast,
>>  	KF_bpf_rcu_read_lock,
>> @@ -12574,6 +12577,9 @@ BTF_ID(func, bpf_list_pop_back)
>>  BTF_ID(func, bpf_list_del)
>>  BTF_ID(func, bpf_list_front)
>>  BTF_ID(func, bpf_list_back)
>> +BTF_ID(func, bpf_list_is_first)
>> +BTF_ID(func, bpf_list_is_last)
>> +BTF_ID(func, bpf_list_empty)
>>  BTF_ID(func, bpf_cast_to_kern_ctx)
>>  BTF_ID(func, bpf_rdonly_cast)
>>  BTF_ID(func, bpf_rcu_read_lock)
>> @@ -12652,6 +12658,9 @@ static const enum special_kfunc_type bpf_list_ap=
i_kfuncs[] =3D {
>>  	KF_bpf_list_del,
>>  	KF_bpf_list_front,
>>  	KF_bpf_list_back,
>> +	KF_bpf_list_is_first,
>> +	KF_bpf_list_is_last,
>> +	KF_bpf_list_empty,
>>  };
>> =20
>>  /* Kfuncs that take a list node argument (bpf_list_node *). */
>> @@ -12660,6 +12669,8 @@ static const enum special_kfunc_type bpf_list_no=
de_api_kfuncs[] =3D {
>>  	KF_bpf_list_push_back_impl,
>>  	KF_bpf_list_add_impl,
>>  	KF_bpf_list_del,
>> +	KF_bpf_list_is_first,
>> +	KF_bpf_list_is_last,
>>  };
>> =20
>>  /* Kfuncs that take an rbtree node argument (bpf_rb_node *). */

