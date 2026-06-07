Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03951E98E3
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780823845; cv=none; b=XV9VJ/34bL8TfZNPTG+R+kWMQYBKN/5cmWe7aNAAI8VLQurNp7cHdr0xpODP6n+IUX49k1wDPb/oJnkJJrqazy8Sg3FprElC/qKTaI+CLpfmJf6+eUFQEqMSLoulktBgsqgl/jRapABvVZ0vcJvSa2umJiVl0awLqeucbeBwgl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780823845; c=relaxed/simple;
	bh=sGRfu/p05xv6+8wOEt3PXH38SdB+tJA9PS7n97haZ8A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=p5LJPMFE2JsgbH4vJAcRj/TqxZpz7SDoEESdG9W7CRHCyF9RPbQ2VOO8W3JI9P6T+6iMfReFf8A2N37gnySyP648Wm2CTIwR+AIGZ3A1tdKH6bq6LVdkb5elXEnfCvy35Rj/d1hIpQaSSoHwubrjnnFVxNxDXJ7wYcoPPYBeMkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnnEQoLZ; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnnEQoLZ"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso27186745e9.1
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 02:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780823842; x=1781428642; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Or/uZEM1Mr/Fy//hQIxqzuqiLQi1LgViOgSt2pTVu/8=;
        b=WnnEQoLZ70Cy29e+cEjIwu6ms3oKEhJFMVRJCQEewXs37RXNgvWhEdmXR5LrbXNOtw
         SBM1ouPHoUelaY+Jx2EJyJbeTuSR3SdUyBBp3acPYV9M86JBwoPxUNJbarj9uIjRXK4L
         WM2ig8na4CAQlMsVlXhechr2dYbr9lZrIuGzjyu8EfeEpvFhg8C5EKOj/s7kxzDSeBPq
         ejtLh5a6j3f0i3b3MQNIUZciR5ioMtjPTkOtIjNTlGOwD7AZbKCMttWwc/UgCq41eebm
         oYkNrvWF2x6TWt5ooeJq8jHvX5rxBMwUgGygK9qLF19ImGodqaLZBp5PE3qMHs5Np/Zj
         DMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780823842; x=1781428642;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Or/uZEM1Mr/Fy//hQIxqzuqiLQi1LgViOgSt2pTVu/8=;
        b=BAE9/SLKsd2ZULpwAEZeXxDcP5Z1FStzRDTAdGYVuX747kG9Xh73rnuw/Nn38F7T2x
         PyvixvqMReSMoBxYi+wUqfI1lTgXqBU1jnk6ueBJr06QEB6wSPbmhhF+R0pBswFF+cuJ
         OX6kiil4eJe1yELlBMvM5DqtlhiYgr71uZIKZ8sPHEshhm7wvTI5IxbbdkXPmDZQqubg
         O8vjkUC5uI0QevbrRrLSRGx8lwXs2UagW93FwbL6MPJkd1Sp5MUvIvI+YRd3lzamRQTu
         xE9ayP9We6bZLGOmlytpE8Zcb6oXxN58EjLRcYMOApzDWHxpREgcJDHJNRhq9PqymQLL
         mVog==
X-Gm-Message-State: AOJu0YxuhgXY8ZvC1dqD+mQtFaIloeHDZoVTFIDmWR0/Sa3I5epry/S3
	VI9U3XcaiUzy3MXspBCHwVX0W/k9HOBuV5XV3NY7KqimkCsI8T1OZL2s
X-Gm-Gg: Acq92OHSwjpD4LswgyuzgLlvqgENzXzZYQ2lN74MO0XMTK4mQ/deRLQnPJpb7V2O4IA
	AJHQAmCaNyhSpHLplQXg2RXlcTHjoOtGPCHGaG2QmBaom0g6E7O9ur4Eax6HR1DgWQOErrP3UbF
	hfCxu1d85aMB3/z+m63Q9YU0nA7hMlBQqSgXBwP0TwlI5dSm7oijmn1JCj6s+xAvHL9QoPIxfj2
	c28b+DAPgFcDHGF9JPk79ZCO4z3KrW0bIRnMSKY5st6SUfr1v8Pphjeu11w9AGayEZQoxAbr0Yd
	syw30dMm4/1najq1EBLyLZAnKA0OPH/gcIeR8Bof+B7LV+GeWgTAqsQDFIWqEpKtSaX70Whd2Mf
	HipIFtnxQoM2Pc9oWPYVDN1wGWK+sxJFpkq3n3ZFWw4eqUZZXCIkRtWtJ2TSI8/vEgmt6Rl1s3D
	IQGboTcBCSLhtjSfur+Rq3M81tOGzKsdlTLcuxS+N+d+X/PHZsfEIsPmyaqOoNS3hS1YJjc6k9m
	G8knX48OBnEs8U51x3nJuBFD9qWW38ROYnhkJv53RqCZO5cZo4fN/DBRkyniYXIcn0Hov6ugPvp
X-Received: by 2002:a05:600c:5248:b0:490:c024:2ec8 with SMTP id 5b1f17b1804b1-490c2522657mr179010725e9.0.1780823842143;
        Sun, 07 Jun 2026 02:17:22 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dce6sm34703602f8f.30.2026.06.07.02.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 02:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Jun 2026 11:17:21 +0200
Message-Id: <DJ2PD6LPWBZH.23QDYT24490ZH@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf, lpm_trie: Allow lookups from sleepable BPF
 programs
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Vlad Poenaru" <vlad.wing@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260529174233.2954240-1-vlad.wing@gmail.com>
 <20260529190220.2090C1F00893@smtp.kernel.org>
In-Reply-To: <20260529190220.2090C1F00893@smtp.kernel.org>

On Fri May 29, 2026 at 9:02 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the fix is inc=
omplete. The patch resolves an RCU lockdep splat in `trie_lookup_elem` for =
sleepable BPF programs, but leaves identical core kernel locking rule viola=
tions in `trie_update_elem` and `trie_delete_elem`. Sleepable eBPF programs=
 hold `rcu_read_lock_trace()`, not the classic `rcu_read_lock()`. The updat=
e and delete operations acquire the map's spinlock (`trie->lock`) and corre=
ctly serialize access, but they use `rcu_dereference()` to traverse the tri=
e instead of the update-side API `rcu_dereference_protected()`. `rcu_derefe=
rence()` strictly asserts that `rcu_read_lock_held()` is true. Holding a sp=
inlock disables preemption but does not satisfy this check, leading to the =
exact same 'suspicious rcu_dereference_check() usage' lockdep splat that th=
is patch aimed to fix.
> --
>
> commit 1ac6e30b3c7fb4d93d67bfcbb5dc35077814b266
> Author: Vlad Poenaru <vlad.wing@gmail.com>
>
> bpf, lpm_trie: Allow lookups from sleepable BPF programs
>
> This commit fixes a lockdep warning caused by sleepable BPF programs
> accessing LPM tries. It updates the RCU dereference checks in
> trie_lookup_elem() to use bpf_rcu_lock_held() instead of
> rcu_read_lock_bh_held().
>
>> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
>> index 0f57608b385d4..ac36063cb7e62 100644
>> --- a/kernel/bpf/lpm_trie.c
>> +++ b/kernel/bpf/lpm_trie.c
> [ ... ]
>> @@ -280,7 +280,7 @@ static void *trie_lookup_elem(struct bpf_map *map, v=
oid *_key)
>>  		 */
>>  		next_bit =3D extract_bit(key->data, node->prefixlen);
>>  		node =3D rcu_dereference_check(node->child[next_bit],
>> -					     rcu_read_lock_bh_held());
>> +					     bpf_rcu_lock_held());
>>  	}
>>
>>  	if (!found)
>
> [Severity: High]
> This is a pre-existing issue, but does this patch leave the fix incomplet=
e?
>
> While this patch updates the lookup path to avoid lockdep splats from sle=
epable
> BPF programs, sleepable BPF programs can also trigger map updates and del=
etes.
> The functions trie_update_elem() and trie_delete_elem() acquire the map's
> spinlock (trie->lock) but traverse the tree using rcu_dereference():
>
> kernel/bpf/lpm_trie.c:trie_update_elem() {
> ...
>         while ((node =3D rcu_dereference(*slot))) {
>                 matchlen =3D longest_prefix_match(trie, node, key);
> ...
> }
>
> kernel/bpf/lpm_trie.c:trie_delete_elem() {
> ...
>         while ((node =3D rcu_dereference(*trim))) {
>                 matchlen =3D longest_prefix_match(trie, node, key);
> ...
> }
>
> Because rcu_dereference() strictly asserts that rcu_read_lock_held() is t=
rue,
> and holding a spinlock does not satisfy the classic RCU read lock check, =
won't
> calling map updates or deletes from sleepable programs still trigger the =
exact
> same suspicious rcu_dereference_check() usage lockdep splats?

Please address this feedback for other instances and respin.

pw-bot: cr

>
> Should these paths be updated to use rcu_dereference_protected() since th=
e
> trie->lock is held?

