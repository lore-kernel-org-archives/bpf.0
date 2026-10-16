Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA4B54704C
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108838; cv=none; b=pWJ3FHQbMR6l5MUErPaREi+1EPRQM4ot/wlNnv6VBWm2Oo1/eHu3AQB9axZXG8U7J9h2sMMGLBHTV9gLWPbkmj5c/WPms7a6zEFMmfWeH0ZWczoIErRnXqymzQVQ0J2W+trb0TEKk/SVZI1peWuzmJ+zdpt7VOdVy1FQjiJk/tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108838; c=relaxed/simple;
	bh=wZY6R6h+1FTYsiykK/FS1yir7juZ5RbueK8o7FId0VE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=YKwP1myD2RQQFGcIOZWgOFTSZRZ1lynWBeuERdFAoeVOKgXZmeVuvlmfKCkrwB1vfMOFyN+xVmsUfVKo6gAGDa/N+XgA+CUXW/sLBbW38H+SeRpuOK9WXCSfHH5ZSwWe28DvMdHksCJhQWauU1NefecNCt3e7nzXII7FQHJWw3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PV2miR/E; arc=none smtp.client-ip=74.125.231.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV2miR/E"
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-4fbb45fdb46so2442529b6e.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 17:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792108836; x=1792713636; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VNSbq9NuIFmu3RW6AfiPOpBRBrk4/5iTbAuNndz/7MI=;
        b=PV2miR/E4LlrWigqxCRcWm62yvTV1g/ZnKIxjLvtT7eJC3K/WirxkW8nb3Zx2gCOzr
         ICEle9wIFvDq+Yv/1L8PyjpoALc2s2MUQ+yqEdwYSadnNcrkYglksxq8f9sjf/w2vxkK
         FIiUDZlkYFuopGdwHyqGgzqplUljSK2YZsHRpHDL+5HL3dPMd8nlG7pEZHTp7Mr5jacx
         MpkM5GPA+0LlgmnTwk3GvWNZaO2mAvKCKhz/N3+t4cgMSCt1jM3yjUzE99sobuQGgoXh
         50eyZJ4Jw7S+FtX4nS5ADa8NbsroIdzas34d6dbmk/R/6WM7lyQETuWzcvrhZuWpY2pY
         U+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792108836; x=1792713636;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VNSbq9NuIFmu3RW6AfiPOpBRBrk4/5iTbAuNndz/7MI=;
        b=Rjb/pNL5ppB12SohMwhddlfva/yvRhiWIutuQ+Xj8tnh2mz2wKDXthnlHfkNk8qXed
         3q4YJb7CDzj1P4QaPtY5PJ5bC31Do+G8rVkkbOhi++lKwNEAcKbjwwkhsy/h3wMTYRfg
         nT2BhpKIi9s0c76Q9wCnhX1qPNHOSsL29muBFeqIEs1elq9G3hBrGb+nAjRgU+rSCdfQ
         MHEyp8EZMLt4Vzlxg9lo9vGeXGxgZdGyAAXiNMZ3CUKmnqzpJ7O+MfLrdIgtnDCIdk/+
         A6qeUlCB6vlSR6PhclftR5FFcb5PhP2q8CYwjK6WOr87YKRHyW9oCQ7bgEXvYh2/BSRk
         z+rw==
X-Forwarded-Encrypted: i=1; AKwUvBwx2Crf0IG+G/NLNNeFFVVwQmpTy+C7AcE0t+RipBz8FK1VRIYD879K0cKMTxg8K7Eyt/4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdKCmC5Z4qKXxh7/iu5Xz213WwUB1OZ6ghYoisPRjomWCMxqx/
	8btxTye20ul9IKakxYfFlWOqeu+V53o1j/Kur1m8+A7RWVEoUTAjGY4ToAW+wi4u2Bc=
X-Gm-Gg: AYBFou1CfMZoVKaIWzBqrQGdlb0s16be0zSKhQNi6+v9LIJ1QSQHaETRy/gH3ZT0V/F
	doAApdNevSqtOf6FgxmKqyKIoQbwF189b7NEsTH+X+B2B5nKxH/jK7qn/beBGHkKI1Hna9NolSj
	mfjqWRTVBmPRb6TmxpIlbPGyGqOhYCEGJwjFkdCMHR1QgD4c2qBzfrpC7rN/jGsasph0QVKr470
	j2T0xcMFMUbo9+RDws6KZ6s6jYkgCGW26xNIhb+PAK0LkdG/SCppcyz7oDnr95Xf0YTw88f25iv
	kYcMjuwEOxh328boZyv1IxzamsrPN8g3tT6N1JCtxG1e9EfHSYkAsunyo8UuobfNEvapklxINyM
	zan5ucZZ+WVcC/tUgUBP4eVTq9yaL4K22H+Ocq2uL9FHWaAIP1wer8PyAKyijwTskLuUVFG6016
	JlEHy4h5kIke+VnZvokY7u/O8wKsvO7YkiBgQRvYFQBZlUrJwPtZu8TyZcR1OMLXlUNW1pVyaYO
	diYfAU7LT/UXU1QakQdjg9RGi4Emjc1zm01cawja5FyN/SQQ3/dm7RwbBywUDklmpW+T8Ygfb9B
	N8wzPegQXzMeZLI=
X-Received: by 2002:a05:6808:1a19:b0:4f4:857c:98ae with SMTP id 5614622812f47-50c52470eecmr18453714b6e.11.1792108835681;
        Thu, 15 Oct 2026 17:00:35 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388a928ab3sm298777b6e.3.2026.10.15.17.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 17:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 02:00:32 +0200
Message-Id: <DM5TK898HREJ.34NDHSIUTC0M0@gmail.com>
Subject: Re: [PATCH bpf-next v3 06/15] bpf: Recognize __nullable on pointer
 members of kernel structs
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20261015234125.3152346-1-memxor@gmail.com>
 <20261015234125.3152346-7-memxor@gmail.com>
 <sashiko-outbox-173494@kernel.org>
In-Reply-To: <sashiko-outbox-173494@kernel.org>

On Fri Oct 16, 2026 at 1:54 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] bpf: PTR_MAYBE_NULL is lost when reading __nullable members fr=
om untrusted pointers
> --
>
> commit 6e594b49287fcdc28cc76204149bfee8d35d1dd9
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf: Recognize __nullable on pointer members of kernel structs
>
> This patch teaches the BPF verifier to recognize the __nullable BTF type =
tag
> on pointer members of kernel structs. It reports these as PTR_MAYBE_NULL,
> intended to force BPF programs to check them for NULL before dereferencin=
g
> them, even when read through a probed pointer.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index f143b1b18b5ca..b4d9ad3ca966b 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
>> @@ -6712,9 +6714,9 @@ static int check_ptr_to_btf_access(struct bpf_veri=
fier_env *env,
>>  			 * aggressively mark as untrusted otherwise such
>>  			 * pointers will be plain PTR_TO_BTF_ID without flags
>>  			 * and will be allowed to be passed into helpers for
>> -			 * compat reasons.
>> +			 * compat reasons. A __nullable member stays nullable.
>>  			 */
>> -			flag =3D PTR_UNTRUSTED;
>> +			flag =3D PTR_UNTRUSTED | (flag & PTR_MAYBE_NULL);
>>  		}
>
> [Severity: Medium]
> Does the untrusted pointer path just above this block also need to preser=
ve
> PTR_MAYBE_NULL?
>
> Looking at check_ptr_to_btf_access(), if the parent pointer being
> dereferenced is untrusted, the code executes this branch:
>
>     } else if (type_flag(reg->type) & PTR_UNTRUSTED) {
>         /* If this is an untrusted pointer, all pointers formed by walkin=
g it
>          * also inherit the untrusted flag.
>          */
>         flag =3D PTR_UNTRUSTED;
>
> When btf_struct_access() processes a __nullable pointer member, it sets
> PTR_MAYBE_NULL in the flag variable. However, because this assignment
> overwrites the flag entirely, the PTR_MAYBE_NULL modifier is discarded.
>
> As a result, the pointer is typed as PTR_TO_BTF_ID | PTR_UNTRUSTED withou=
t
> PTR_MAYBE_NULL. The verifier forgets that the pointer can be NULL, bypass=
ing
> the required NULL check and violating the explicit design intent describe=
d
> in the commit message.
>
> Will BPF programs be able to bypass the verifier's mandatory NULL check
> for __nullable members of untrusted pointers because of this?
>

It's not a bug but makes sense for consistency. I will follow up or fix in =
the
respin if we go that route.

>>  	} else {
>>  		/* Old compat. Deprecated */


