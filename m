Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D6539DBE4
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673795; cv=none; b=M2CTT+un2ccIlglXegM7ecJWTmuGyUwXL4xV1OR9F38kqRMTu8cbOgh2egkijozMTyb9HY2qeH+jMhyLP5Zd6LpiHa91c2p2Nu5sL166J5QIGcd0fYzKWQgnLx39q5fJHZEv9nvEr7Yw5WiIMOXzN3osAZX2BryqBSVgTVQ6Pko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673795; c=relaxed/simple;
	bh=HKHOkWhH6BU2/Kw6JDHK+1RukHquEOSZU3JErWjo5j4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=H62DvyyXm++jKsaSqBQ/UkCrLYiwLxdgx5ky13LIC7NS2f9ngqC0Kds1YPNzL5PmrETbZ6gATZeVoOndZqoXmJeAUKS4h7u5q2owU+EEOPtxHdW/MQgWXtXDxAr00QJL0wTq3FeVzdVZYrat0YliykmDBaN14C+6SobsiuUfikE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=jFCqGnMv; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="jFCqGnMv"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-506a6cf8242so43304151cf.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 08:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773673793; x=1774278593; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCdM8x+1KXX/GsYpxXRz4pvAs7gwFa4GWzBiUtiGEw8=;
        b=jFCqGnMvihSGTrM3O21kbrxE2UhrFe9wnfsr0RXMM0+PH75uww2llNK/XiMlIlYXrR
         U5SL64wPuwFEuzsfDI8nAlnxuug1xImeEdmXbzXrhXr5TlKjohKV+qB2uN9WXllV3szg
         NG8bHmwbb9zqKzmfWXWlCYreDmtviDhg1HHJf26occ7x1qPZX6SueZEW+k3UVnOEeOiR
         +Ztx8Br4A91AlsNemsYe6PRha7G6UrHDzpxiLXHoykPGwgZhALhmj2dqrqnAXH/9cR71
         8a+SsQ+so+J8mFl66+7PLlbu1m/Xl0vLKjFrCwjL+bmqF3EVMA2S19zUldUrJPw+HJj0
         VyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773673793; x=1774278593;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fCdM8x+1KXX/GsYpxXRz4pvAs7gwFa4GWzBiUtiGEw8=;
        b=UPpH5ELrte9H2DG/azuZ+Evkc5N8pmKYCUOGF5Tk0LguAKSEsJnPkMzNuCp3UW50wp
         fbpPsPQeu2BqK16yLnYpkbycX08ZuWX9+4rCD4/5JLCy6phHYlR36Mx4kw093Cv3ZUIc
         eE3F+73FsbjN6ipbpQ2bVfyl5sSjtbMre4A5jYNLTLf3C20H5Yq5wS3cNNBR9U22niKJ
         hjeCDEXGUo0Swly3hSs0aH3r61tk0TOTuLEM4xQM98vmkctDtakdFnHhjLmXt+bVl94D
         CjVe4NATfmKwqRz5k4in6gZu+jn7b0BRqQGLVkbErsXLoLdg2DJYqwibSjBmNY715ptT
         KZeg==
X-Gm-Message-State: AOJu0Yy22wHRZ3oOIp3DlqITjph6ehhZw6w0au877h9tYgZMhjCPe7Mh
	5lzxLLcA8IeSVP3S/6ewbRfsj2qfSLfzzELVuYkWijhW0Yo4jL0YKRz7WTjT9LtZ3cA=
X-Gm-Gg: ATEYQzxMOnMUmpbnIEuYETtssFr0i+1RXXXr9C4riA4jpkEUC+vAjHxHMasr8VlTX8U
	5m0Q/NbsVT+py9kz4Awij1nC/3UpyiYtcbFDb9oRJVBi6/Z9TLRdoIrcg3SHj3cxGGR5QZvSOdp
	+NL3K3UsedWZ+/fiOc+B89AIqobgah6yCmbaq4nBpPer44bYtKbhoEb1NzsFsZggUAFzN4bPwyg
	EJICGjEITRg8kKzFzgyA+eLVNP7ydTDJhM66jQoS31dukFTYZmrXZHcydD2Ot2j/BKm7svmRghb
	FmFYArh4p6kUdCj2459tsWJ27GYsHRk64bhGkJ/KCrJ0+pkuzIzPaVBSdNPRjg4qZkYB/mPRKj4
	F135uI8IVxGDwRrP8L+clVIaFR9Ykb/UMHEwTUZrzhDbADrJtw3yv/ggCruBkZ273k0U5UWhv+h
	m8AbvrADv1oGa8kXIQiHpciyE=
X-Received: by 2002:ac8:5dc9:0:b0:509:1d45:f216 with SMTP id d75a77b69052e-50957dc7ee5mr176625441cf.45.1773673793006;
        Mon, 16 Mar 2026 08:09:53 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a0ea230sm121181871cf.19.2026.03.16.08.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 08:09:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 11:09:50 -0400
Message-Id: <DH4AVUUSLYT5.1WWVVAWM0D5AX@etsalapatis.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard" <eddyz87@gmail.com>, "Martin KaFai Lau"
 <martin.lau@kernel.org>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Only enforce 8 frame call stack
 limit for all-static stacks
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1
References: <20260311182831.91219-1-emil@etsalapatis.com>
 <20260311182831.91219-2-emil@etsalapatis.com>
 <CAADnVQJ7c-biuSzin6+-Jt=xDEP0+PdJPwR6xDPCQDYjf_9qvg@mail.gmail.com>
In-Reply-To: <CAADnVQJ7c-biuSzin6+-Jt=xDEP0+PdJPwR6xDPCQDYjf_9qvg@mail.gmail.com>

On Fri Mar 13, 2026 at 10:40 PM EDT, Alexei Starovoitov wrote:
> On Wed, Mar 11, 2026 at 11:28=E2=80=AFAM Emil Tsalapatis <emil@etsalapati=
s.com> wrote:
>>
>> The BPF verifier currently enforces a call stack depth of 8 frames,
>> regardless of the actual stack space consumption of those frames. The
>> limit is necessary for static call stacks, because the bookkeeping data
>> structures used by the verifier when stepping into static functions
>> during verification only support 8 stack frames. However, this
>> limitation only matters for static stack frames: Global subprogs are
>> verified by themselves and do not require limiting the call depth.
>>
>> Relax this limitation to only apply to static stack frames. Verification
>> now only fails when there is a sequence of 8 calls to non-global
>> subprogs. Calling into a global subprog resets the counter. This allows
>> deeper call stacks, provided all frames still fit in the stack.
>>
>> The change does not increase the maximum size of the call stack, only
>> the maximum number of frames we can place in it.
>>
>> Also change the progs/test_global_func3.c selftest to use static
>> functions, since with the new patch it would otherwise unexpectedly
>> pass verification.
>>
>> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
>> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>>  include/linux/bpf_verifier.h                  |  9 +++
>>  kernel/bpf/verifier.c                         | 62 +++++++++++++------
>>  .../selftests/bpf/progs/test_global_func3.c   | 18 +++---
>>  3 files changed, 61 insertions(+), 28 deletions(-)
>>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 090aa26d1c98..f31194c2f0a8 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -742,6 +742,12 @@ struct bpf_scc_info {
>>
>>  struct bpf_liveness;
>>
>> +struct bpf_subprog_call_depth_info {
>> +       int ret_insn; /* caller instruction where we return to. */
>> +       int caller; /* caller subprogram idx */
>> +       int frame; /* # of consecutive static call stack frames on top o=
f stack */
>> +};
>> +
>>  /* single container for all structs
>>   * one verifier_env per bpf_check() call
>>   */
>> @@ -851,6 +857,9 @@ struct bpf_verifier_env {
>>         u32 scc_cnt;
>>         struct bpf_iarray *succ;
>>         struct bpf_iarray *gotox_tmp_buf;
>> +
>> +       /* temporary state used for call frame depth calculation */
>> +       struct bpf_subprog_call_depth_info *dinfo;
>
> It doesn't have to be part of env, right?
> Could you just pass it as another argument to check_max_stack_depth_subpr=
og() ?
>
> 'env' is for things that need to be around for most of the verifier's
> duration.
> This one was added to 'env' just to avoid an extra argument
> between check_max_stack_depth() and check_max_stack_depth_subprog().
> Why?
> Seems like a wrong tradeoff.
>
> and with that struct bpf_subprog_call_depth_info can be local
> in verifier.c?
>

Moving the struct out of env and into verifier.c is a strict improvement
over the current version, I will adjust the patch and respin.

> pw-bot: cr

