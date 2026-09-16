Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4814E2F34
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 21:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592643; cv=none; b=lZhjisZL29ElQAilrhUW6XlpdbThbHRD8jxCv4lhIw/ru1b3fkQ6Nb1O9kd3gJGcGxyJU32AWRgmyDCh7OC5fwOOkjL285wkyOeSNFqC64I/ZZywnQyTwxSTjWuL/5s3D/ZJRJghCNMA1XMt/EfTmEmn3m/nQ8pseFSnrFVdgEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592643; c=relaxed/simple;
	bh=KIBq/JIf4PMqIg02hDFMcnShGZfWRiQIlPjxO7hYpTo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hwsfTCD4eCsSzYL6ZsJc4jxMT2r015U1hKDxmV8wY8Sra1Sg2CgIhJeb4UYVwBqi7ZrR1vZvDAzqbYMpeZzfgP2QxT6NcO7VRnEbsT65OI2pg7TrO1bV1i3orlAg2A1tqLsJ5eIUHfcy7CvYSBd2AIVFLuvu6yP2YJUb9JtvsEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9RvOms/; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9RvOms/"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396cccbba92so123856a91.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 14:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789592626; x=1790197426; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kfinaVrsWxppFu9cJ0KQHIlyqRFy5IgWBXjYXxf3a5Q=;
        b=Q9RvOms/68DOQ8YoHZX7sD0H0ooks2a4VGyC59vEHF6lR4kIyjUnu7sqmWjZ0OZncO
         J8ZGtL2XAMHIW62+EP1EhGC3oxu/D0gyjNfHP8UKkwrmp0pAyotni/jPKC+BgJi0+fHb
         /Bd3/q7tE/p45At6G4Sw525bj6ir9vnFCe+5cxE3eCh2NbZsWWyPCQhbMzkpUiNHB3bG
         kcOzyCzc1ZexlMQdOLRODf1ESLYDr03S/CAlmQ6kZnhzKGAzH7HfWmgjS1C8NixKSuX5
         pkGOxwQu38ADurfbVGjIllCzSY/zAUSjCe1gogrr4o0np9034PJ2S27bsfBhbh/kaiwu
         Ix1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789592626; x=1790197426;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kfinaVrsWxppFu9cJ0KQHIlyqRFy5IgWBXjYXxf3a5Q=;
        b=RKVSodn1y+hWlIB2Lt4+SgWb4hGbX6iF5WUS+ggpNc+ZGS6KJPpRxC5X8P+eHMQ7Y1
         jbKnFEhbxi49wmsbpFcG7nNPN8ZaseHUUHErRM/eff/QikcskoU9APgdlH9ImbCLC95v
         sadcOQkZygLeOSf7URYO3LjwAODRwxu0iUAqEOBqplYbee2ENtch6KKiOXCdKAQ8+qrT
         ttdNqq6e+nhMkp2nELGLD7WHhDg2yC2bMbgNpDoSYPAFI+lbCdyqt6+B/r/YCO94+aTY
         tLk7cqf/olCIYi2M963Ha99MYqEDSP1Jt1X1g8BUQFr2l2F2TOwCBnH2JYfbtQXatB8L
         JU9w==
X-Forwarded-Encrypted: i=1; AKwUvBw59W18rPe4+O0ehGSW6seUlbAP+o+Yjvm5l7MRGl/8rMGA1S+gP/RdJdwwGKuLaIQRe5A=@vger.kernel.org
X-Gm-Message-State: AFuF++lCcmUXDYivHZ+f7fZyhY1xfNqGh8j+9whqsMaUR5zFysPb4nTG
	nFbyl7q2mOT/8QJO58rRKM1GKFQDv/YQFKnOyTOrk+8TdHbDi5Q3VLv0
X-Gm-Gg: AYBFou1gcFSCf4GI9TWAlhJiKsaSUeTrxAAtuqQ6vZ/AkZfa3IPmELbDwZmPOmXHp+M
	d5XMe5iVl6CE4rJnWK+QFi5b67WhaE+1v9Wbr368VBYhr9jcF2qM1s8X8EYxzBlchuarI3cWXGt
	hrZupfslbm1scuMiMhhWaNLr5x3fT0lt4uuxsvb/jghsytYkbXAugiBXgeT5GDUkKVRdAi8Plb/
	/mPw+H/1D5kE/oo3HxjZTSBbdRunhfu14yXhIl0jMbc17hek0t4AMgMj+xwtLMxXGLp2lOLPXP/
	PukZLUlSVmSDluqswEeQL9gjRkjn0VglVS2MG8JJUTuV0D+Yr3Boa/juFnvcwOyRS/8J6sJ3uty
	LcC9nZbDfxXL5javl3GGa8LAXRJOuxnzAXNRtWJZ1poQra5TFYGnwb3MCfGOz0N8p9o5Q0OSfZ/
	V515JEYTqLPOBJ68j+CtPvm9urCIP7eu3omT4HHGR/Yzv4+z53rnXNmhnAIoP1FS1Fa4/aHdNT2
	ODxuMpFfGgCNyN4ypcL4+8O3suxamIc+Fxhqui2bSn3YeKGC2F0IqWZCWSrL7PBHyQECtqf/7vm
	uJ774SZAg5iVmQV7aCvSRhjfHgqesqUTXwqGJW3pjncHCseZwNzTVtqQTKq7DzehDNc=
X-Received: by 2002:a17:90b:280a:b0:39d:fcbe:fdcf with SMTP id 98e67ed59e1d1-39e1e2659a8mr9947756a91.1.1789592625686;
        Wed, 16 Sep 2026 14:03:45 -0700 (PDT)
Received: from localhost (ec2-100-21-52-215.us-west-2.compute.amazonaws.com. [100.21.52.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e39b8df99sm126076a91.3.2026.09.16.14.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 14:03:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Sep 2026 21:03:43 +0000
Message-Id: <DLH1N1KP02XT.1KJ79QEMQORI2@gmail.com>
Cc: <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <john.fastabend@gmail.com>, <shuah@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <martin.lau@kernel.org>, <mason@kernel.org>
Subject: Re: [PATCH bpf-next v2 01/13] bpf: move linked-scalar flags out of
 bpf_reg_state->id [NFC]
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>, <bot+bpf-ci@kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>
X-Mailer: aerc 0.17.0
References: <20260910164635.459558-2-vineet.gupta@linux.dev>
 <6ba21fcb39349c144c340d3605e25a30710ff43c5ea0c53045e78f4408411fdd@mail.kernel.org> <4cddd4a4-d684-46c9-862e-5708797f399d@linux.dev>
In-Reply-To: <4cddd4a4-d684-46c9-862e-5708797f399d@linux.dev>

On Mon Sep 14, 2026 at 6:02 PM UTC, Vineet Gupta wrote:
>
>
> On 9/10/26 11:22 PM, bot+bpf-ci@kernel.org wrote:
> >> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> >> index 66fb11b6c6a7..d974baad37ee 100644
> >> --- a/kernel/bpf/states.c
> >> +++ b/kernel/bpf/states.c
> > [ ... ]
> >
> >> @@ -369,13 +369,6 @@ static bool check_ids(u32 old_id, u32 cur_id, str=
uct bpf_idmap *idmap)
> >>    * and r7.id=3D0 (both independent), without temp IDs both would map=
 old_id=3DX
> >>    * to cur_id=3D0 and pass. With temp IDs: r6 maps X->temp1, r7 tries=
 to map
> >>    * X->temp2, but X is already mapped to temp1, so the check fails co=
rrectly.
> >> - *
> >> - * When old_id has BPF_ADD_CONST set, the compound id (base | flag) a=
nd the
> >> - * base id (flag stripped) must both map consistently. Example: old h=
as
> >> - * r2.id=3DA, r3.id=3DA|flag (r3 =3D r2 + delta), cur has r2.id=3DB, =
r3.id=3DC|flag
> >> - * (r3 derived from unrelated r4). Without the base check, idmap gets=
 two
> >> - * independent entries A->B and A|flag->C|flag, missing that A->C con=
flicts
> >> - * with A->B. The base ID cross-check catches this.
> >>    */
> >>   static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idma=
p *idmap)
> >>   {
> >> @@ -384,15 +377,7 @@ static bool check_scalar_ids(u32 old_id, u32 cur_=
id, struct bpf_idmap *idmap)
> >>
> >>   	cur_id =3D cur_id ? cur_id : ++idmap->tmp_id_gen;
> >>
> >> -	if (!check_ids(old_id, cur_id, idmap))
> >> -		return false;
> >> -	if (old_id & BPF_ADD_CONST) {
> >> -		old_id &=3D ~BPF_ADD_CONST;
> >> -		cur_id &=3D ~BPF_ADD_CONST;
> >> -		if (!check_ids(old_id, cur_id, idmap))
> >> -			return false;
> >> -	}
> >> -	return true;
> >> +	return check_ids(old_id, cur_id, idmap);
> >>   }
> > [ ... ]
> >
> >> diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars=
.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> >> index d571fbfc86a3..da6cb961a520 100644
> >> --- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> >> +++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> > [ ... ]
> >
> >> @@ -648,10 +648,10 @@ l_exit_%=3D:							\
> >>   }
> >>
> >>   /*
> >> - * Test that regsafe() verifies base_id consistency for BPF_ADD_CONST
> >> + * Test that regsafe() verifies base_id consistency for ADD_CONST_*
> >>    * linked scalars during state pruning.
> >>    *
> >> - * The false branch (explored first) links R3 to R2 via ADD_CONST.
> >> + * The false branch (explored first) links R3 to R2 via ADD_CONST_64.
> >>    * The true branch (runtime path) links R3 to R4 (unrelated base_id)=
.
> >>    * At the merge point, pruning must fail because the linkage topolog=
y
> >>    * differs.
> > Does this comment still match what the code does? The patch removes the
> > "base_id" concept from kernel/bpf/states.c (deleted the paragraph that
> > defined it, removed the two-level compound/base id check from
> > check_scalar_ids), but the comment here still describes the test as
> > verifying "base_id consistency" and refers to "unrelated base_id" on th=
e
> > next line.
> >
> > Looking at the function name and __description below:
> >
> >>    */
> >>   __description("add_const base_id must be consistent for pruning")
> >>   __failure __msg("invalid variable-offset")
> >>   __naked void add_const_base_id_pruning(void)
> > and later at line 695:
> >
> >>   	/* Runtime: R2.id=3DA, R4.id=3DC: base_ids A vs C inconsistent,
> >>   	 * pruning should have failed. */
> > Should these be updated to use current terminology, or does "base_id"
> > still have meaning in this context? The test itself still works correct=
ly
> > after the patch, so this appears to be a documentation consistency
> > question rather than a functional issue.
>
> Indeed base_id as a term is gone, but just id alone might be confusing=20
> as well.
> How about link id as a replacement for base_id

I don't think "link id" fits either. Just use id.

