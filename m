Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3340535676B
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418579; cv=none; b=ljLqDzeJZBtifxP4NlnmSVs5iF7NYHdik6+HCxfUtWOyPwJnTn7+MdT42/E/BHjLbJQpF+UedutwVq83BlKxJqJpbLWKqL6TcQNkeSk13JHP2JHg/PE71ysA3Wy+GaKNY+K6Vh5hyPa5KIbwPSKCnSsAvNmvPPkKD89NyW4ycgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418579; c=relaxed/simple;
	bh=hiczTbOUIWXnM2SnFOJsL1YTqjaxxwJOHxJIe/NwVlY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AIKwbnbS0X6WP2KwsRNw3zsv429PqT5p1uCF4CEsskNcxqiMq5fu3EDCwRVufWTXcTpSULg/A/YQIf7sLGn3EDA8pRopOXpwftC8KS+Klc0auC+1cNHNhf65gBr9oYuDLnv0Z4EHIPK8B5n1XtYDrPpc0FSXcG8jxU+kSiPRfGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPAN2qDl; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPAN2qDl"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48433107499so1758393f8f.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 13:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789418576; x=1790023376; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YnxpnSJYa48NMyGe+M2KKeTAvnzXyjynVqFh9DNxdSE=;
        b=aPAN2qDllTT6vHLU4jm/CNwYM+J2d6p3BkdpVijsuJylao0o0iV0b3fCdi/VOriHDN
         PXd7cLXfhuzNaL6TuRBqxsM+x6HLbDvBTeUCV3K6SRxCjII/K6+UVHXJSVY+cEWJZz7t
         Wjppfd1BdG2jemT2pvCQOmVWFNVkibafvXijDYTYnc12WS2vfVUh7Uva1awqBnLUkgX+
         giRbzfLJBXHgdLIeBuHHSrzQujmMzcKApKdL8hQLKatDS6VoYW4UpIO8XEy9GWLvqasQ
         FK8ZoW3E7rd6nmwiBZq+i0QekXV+4hVbWIROTF3DArdKCxJ8uC8Fq9d91SYXM2uFHxho
         s7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789418576; x=1790023376;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YnxpnSJYa48NMyGe+M2KKeTAvnzXyjynVqFh9DNxdSE=;
        b=PgN4c9z6+jKYbQGAizoycCKZTZxs8gyOY+Ds4AfrIwO1frqrW2a3n5I1xmuwo3b5h4
         sesJrRQDBZnwJ5MG4lvpGdXqsaq1xTbvhuByLk4ZeYCJUoV6grZPGN9kqUsrkr6Lw5dL
         4GylK9bGMkcHEuFt7In+sQvXdMPWxhk+ytywsVfdar0EqFTkMkxGMawZehUBaXXKOT4e
         bpklSHgxI4J0vYfeFd1QpGKPlAUP9KXx1hbQ0qisN+knkZBwJLZXbyMpSxJ1oZLzlL6J
         k9SFnKn7bYI6S5tNmN6wrzOkQo0jP7w8vystzW9+K3HlOV5Ye/XHFsIisFj6ngcICXKb
         tHsA==
X-Gm-Message-State: AFuF++m6/fKXR/FrGkuNPhGj1hfZXaHKnycCQMHy83BFP4a+PJiJlSU4
	YJAcyjdjcMtxBy7sw2duNQfr02TVARY8/guNoepXUo49w/pnu0odg1mt
X-Gm-Gg: AYBFou3GJMip2APwPUzhOoBLYYd4LrD7QoWsGN7Q5PS9zbVSBpUrdu0txIjRbALhPJF
	ACi1Kzg3i9oyrxEpveFyVWWVnKtECLJp1iqANKqpYP8om0mz7vCxhVfl72knObW83B59TJrXeiR
	26uKlsLL1SJMHn5mYXbresTmo6X0nEhGkMLRHeemCPGdVV16k+KkJUwWDm50oa03x6uP/j6KQTa
	4wB6RJACMd3X133F2d9+eYb5gLvE45Cq29iXOYKTgn9deVK4dqj7txUqTNujONV7meGVMHrxvFb
	6/mN/6vqATBKc3fQzaivEK69c+guoo540JM0eWn3Muu7P3nP2R5H/EglIwYLUZ5VBOxfwdZj7oP
	lrxvrod51DDQuSJWAlb2vZkaUb2jGEpsROScquVhimUGb2PHXe5BAgvOMl/4es++gTTFKQ68BEy
	mq0J57zDW8t2Vu0XoHViyf6Ic3gPAyWhels4wQIy8CxIqpSb29vtl23ih9oxTEiNWcAPIlkUzpO
	Q20vDQ4NzBtAtuuITUtocr8ZhIHmDxNkzvkpl7dhMruB7fsHZfyWI25fcuOkvMrdaeB/vNULxuU
	76aafjM11zsrDslJfUV8aBDFPczATyHY44oeZw==
X-Received: by 2002:a05:6000:41eb:b0:486:f77f:7b04 with SMTP id ffacd0b85a97d-48702aa864emr5399328f8f.3.1789418576062;
        Mon, 14 Sep 2026 13:42:56 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ea4fsm30654911f8f.21.2026.09.14.13.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 13:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 22:42:55 +0200
Message-Id: <DLFBY0XAL5NW.33SRTMMYCWJHZ@gmail.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Nicholas Carlini" <npc@anthropic.com>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <kkd@meta.com>, "Kernel Team" <kernel-team@meta.com>
Subject: Re: [PATCH bpf v3 4/7] bpf: Restrict CO-RE poisoning to relocatable
 instructions
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Andrii Nakryiko"
 <andrii.nakryiko@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260914131701.2529725-1-memxor@gmail.com>
 <20260914131701.2529725-5-memxor@gmail.com>
 <CAEf4BzZjrWzQxaZ1kXyvXHXuUFDsgZe6NwQHH6seqfoMLpJLZw@mail.gmail.com>
 <CAADnVQ+SOswCXzZbCbjtjXQDd++Zkrxpg4k3gHMsMPsN9BRQEA@mail.gmail.com>
In-Reply-To: <CAADnVQ+SOswCXzZbCbjtjXQDd++Zkrxpg4k3gHMsMPsN9BRQEA@mail.gmail.com>

On Mon Sep 14, 2026 at 10:21 PM CEST, Alexei Starovoitov wrote:
> On Mon, Sep 14, 2026 at 12:54=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Mon, Sep 14, 2026 at 6:17=E2=80=AFAM Kumar Kartikeya Dwivedi
>> <memxor@gmail.com> wrote:
>> >
>> > check_subprogs() verifies that each subprogram ends in an exit or an
>> > unconditional jump before in-kernel CO-RE relocations are applied.
>> > An unresolved relocation can then replace that terminal instruction wi=
th
>> > an invalid helper call. The resulting fall-through into another subpro=
gram
>> > breaks the CFG invariant used by postorder and stack liveness analysis=
,
>> > which can write past their per-subprogram arrays.
>> >
>> > Handle instruction poisoning after the instruction has passed the same
>> > class and operand-form checks used for a resolved relocation. This rej=
ects
>> > relocations targeting jumps, calls, exits, register-source arithmetic,=
 or
>> > non-immediate loads before they can alter the control flow. Keep poiso=
ning
>> > supported instructions, including both halves of a plain ldimm64, so a=
n
>> > unresolved relocation in dead code remains valid.
>> >
>> > The shared relocation code applies this restriction to both libbpf and
>> > in-kernel CO-RE.
>> >
>> > Fixes: efcda22aa541 ("bpf: compute instructions postorder per subprogr=
am")
>> > Reported-by: Nicholas Carlini <npc@anthropic.com>
>> > Suggested-by: Nicholas Carlini <npc@anthropic.com>
>> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> > ---
>> >  tools/lib/bpf/relo_core.c | 28 +++++++++++++++++-----------
>> >  1 file changed, 17 insertions(+), 11 deletions(-)
>> >
>>
>> Kumar, can you please see if we can move check_core_relo() to right
>> after bpf_prepare_btf_info() instead of trying to guard against
>> malicious CO-RE relocation? I think what CO-RE logic is doing here
>> with poisoning is correct, it marks instruction as invalid because
>> CO-RE relocation couldn't be resolved/applied/whatever. That's sane
>> generic behavior, IMO.
>>
>> The fact that this breaks subprog validation is more of a sign that we
>> do this CO-RE application too late, perhaps?
>>
>> Also looking at current bpf_check_btf_info() logic, seems like we'll
>> skip CO-RE relocations altogether if we don't have
>> func_info/line_info, which is... fine, I guess, in modern world. But
>> it certainly is a bit orthogonal. So check_core_relo() seems like a
>> stand-alone step to me, which hopefully can be done very-very early,
>> so that no matter what patching we did will be properly validated by
>> verifier.
>
> Let's do both:
> - move bpf_check_btf_info() right after bpf_prepare_btf_info()

This won't be a copy paste, since it depends on various checks on subprogs =
we
would end up skipping, but let me see how we can split some of the steps an=
d
whether that ends up looking too bad.

> - check that relo applies to relocatable insns only
>   and hard error if it's not.

Ok.
