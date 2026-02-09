Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4749221F15
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 21:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770672687; cv=none; b=l2TUxvj3Y9l/Ao4sVWXyYUPh90X5K6hzSW45v5qmfDcagXQ03q1JbAImyQGhaXm1/BDwhIMvIWX/NzLlQ0nGloqZpMLXQpqDVSCe4rnEBKCh03r9lurWwPJ/4kPwEBzz60uHw8Vxp+wBnFRmkWcXQqMTJv93SPB+B//mlga1r/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770672687; c=relaxed/simple;
	bh=C2MIJ/S4Xgo1Y81/xdY3UxppjMlrdX7J72qfgeKxwQg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QLHI86e5Ny9RMOlbKgoNJ6Klbinx4MoOjqGu3yyxztHq7DIN2v9K7yUdvVfVh2jeHs8wGFlF0fRobGknmdNZCsJZGU26FOObHphB3mqhKk7S8tOIXsGodoxOyBt9piM2Ye5RsRw0nrJ/nZWx7PIpVWA+ZlC94tkvPJQitpOgXpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=hc82TKBy; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="hc82TKBy"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8947e6ffd20so70391576d6.1
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 13:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770672684; x=1771277484; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cp0oxYql2Q/nucKtsKTvacfgQ9Y0Fzz+OPjL0bdYe3c=;
        b=hc82TKByLLAvYAr2gQNZVEpJWBxnzStI5jNnqIZRmLl/3K8MOfvTDjW9Hn8A98N7JZ
         Y4svSdJgR8BfoDOncdarY5MN5njMIkrMYMLo94PEekhv74ih638leRlrwoe7ixEyWJE3
         caaZwCob+2hxvRKbTBqNwppz6JqSGow9f0tDx0nPl6NQIsO/S5qB8w854Lxuau3wr74E
         xhEBGJ5XOrlh48SYDyk+2j/r+KBK9ceLx+Y1YLXjWaLymDOZTgRaEvG1Mb6Y1aPWZ5Tk
         vYS56c7NMiRxwOumCwspbO/+0xKz0g6lrmo00rTCVZok0SKEF4ftb5Vm2JafNKGNtkk6
         3PQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770672684; x=1771277484;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cp0oxYql2Q/nucKtsKTvacfgQ9Y0Fzz+OPjL0bdYe3c=;
        b=K097YnrKF7+O6+kUVCa7uENypdNNuaig6KhekYL9S1o9g6L4uRtgqOS4K/et2cG6nm
         yHCoVlmaigDdbTs8/om2Ux+0Gad+rfxT9hePNJFoIFZOhgl5ZX3icFEPfrsFZmlUoDOJ
         yPIFg0jSMKMxvKkuaaW51EbFD+ue2Aqe8L5rLVRuHMOwr0tNhRblyVrKqZZfovH1sUFu
         6z2/++PMShLax5B67IhNYYAj+Qew1YBuBzmnE/pmGApo7fhzSFhzsJjeSamS8IhoUEpJ
         EZHDOpE3Nm/09bLW8gz0cvuM20mmeFjQP6JgbrTap6Ok/Da2If+VErAqh845LJp2tTEO
         90Ng==
X-Gm-Message-State: AOJu0Yw4h3NG8O2gJt0mDlTQvEZzTed+Rq48Pz0u7rMK8XJeXkC9LbVT
	IjCtoVbaAhJxHvo8mxnQ2M+hg9qhiSDJpBpnGOkP7oOqFA/3jJqfOdeQtKpDIZRnwXU=
X-Gm-Gg: AZuq6aKFqCpuDLTDabjuUu0pjw07O9qdtDP0B9HEbp4yT7VEUaHt4tuLNjJesGqVUIu
	k+MkZjvm9jwT4VlWX/JV1YOWg069g3wTJbJwxbvYponBh/eMO9oBp2ihhXqFYUqjCpenfq5drgY
	FeB9ed36r3Q7nwpUPQS8E8D4vNtQAtrD8ddMVlCvVyP2qDf71qzhOpCjCtmnx1+LVIAKvR0wNtE
	OMMpBj6eGmPFF4sJGQ3/wuy/jYrdlrZqQrN7qmzMR3BTDE/2qiaUZWM+2kSvBOXaACSgadlWYdV
	g75NYuRtFXeAIett2+IPgN+zD4pHtFXF1+CBqz750xiVSKwstKK//nnRNhdUfTfCSw63VPRTCFa
	paloQ3m2oXkbfI+9QOWZ18k70MPpc1Oezn2ubkM9jWoLEMLLWQO4tKUpRQ68K89luIZ4evHhznk
	ezzOpmRE/+IE8=
X-Received: by 2002:a05:6214:401c:b0:894:6622:a6d4 with SMTP id 6a1803df08f44-8953cd8f0bemr174356916d6.61.1770672684425;
        Mon, 09 Feb 2026 13:31:24 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8954c3f01f7sm58997036d6.30.2026.02.09.13.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 13:31:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Feb 2026 16:31:22 -0500
Message-Id: <DGAR2WVP7UZ9.AB10375QNXC5@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <martin.lau@kernel.org>,
 <memxor@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next] libbpf: Add gating for arena globals
 relocation feature
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
X-Mailer: aerc 0.20.1
References: <20260209210240.2051209-1-emil@etsalapatis.com>
 <CAEf4BzYz3KBUyqR+OJCMns2Edsd+Dhyij=f8cqSEyY9OG0KCdw@mail.gmail.com>
In-Reply-To: <CAEf4BzYz3KBUyqR+OJCMns2Edsd+Dhyij=f8cqSEyY9OG0KCdw@mail.gmail.com>

On Mon Feb 9, 2026 at 4:23 PM EST, Andrii Nakryiko wrote:
> On Mon, Feb 9, 2026 at 1:02=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>>
>> Add feature gating for the arena globals relocation introduced in
>> commit c1f61171d44b. The commit depends on a previous commit in the same
>> patchset that is absent from older kernels, causing arena programs using
>> arenas >=3D 512MiB to fail to load and breaking libbpf's backwards
>> compatibility. Introduce a libbpf feature to check whether the running
>> kernel includes the required patch and only relocate arena globals
>> if it does.
>>
>> Fixes: c1f61171d44b ("libbpf: Move arena globals to the end of the arena=
")
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>>  tools/include/linux/filter.h    |  10 ++
>>  tools/lib/bpf/features.c        | 178 ++++++++++++++++++++++++++++++++
>>  tools/lib/bpf/libbpf.c          |   7 +-
>>  tools/lib/bpf/libbpf_internal.h |   2 +
>>  4 files changed, 195 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
>> index bcc6df79301a..70d4b5c08a7e 100644
>> --- a/tools/include/linux/filter.h
>> +++ b/tools/include/linux/filter.h
>> @@ -366,4 +366,14 @@
>>                 .off   =3D 0,                                     \
>>                 .imm   =3D 0 })
>>
>> +/* Program address space cast from 1 -> 0 */
>> +
>> +#define BPF_ADDR_SPACE_CAST_TO_ARENA(REG)                      \
>> +       ((struct bpf_insn) {                                    \
>> +               .code  =3D BPF_ALU64 | BPF_MOV | BPF_X,           \
>> +               .dst_reg =3D REG,                                 \
>> +               .src_reg =3D REG,                                 \
>> +               .off   =3D BPF_ADDR_SPACE_CAST,                   \
>> +               .imm   =3D 1U })
>> +
>
> Note that this won't be available on Github mirror side, we'd need to
> add this there as well (but I hope we might now need it after all)
>
>>  #endif /* __TOOLS_LINUX_FILTER_H */
>> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
>
> [...]
>
>> +       opts.prog_btf_fd =3D btf_fd;
>> +       opts.func_info =3D &func_infos;
>> +       opts.func_info_cnt =3D ARRAY_SIZE(func_infos);
>> +       opts.func_info_rec_size =3D sizeof(func_infos[0]);
>> +
>> +       prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_SYSCALL, NULL, "GPL", in=
sns, insn_cnt, &opts);
>> +       munmap(mapping, arena_size);
>> +       close(btf_fd);
>> +       close(map);
>> +
>> +       return probe_fd(prog_fd);
>> +}
>> +
>
> ok, wow, that's quite a feature detector :)
>
> but if we take a step back, we really are just trying to detect the chang=
e in
>
> 12a1fe6e12db ("bpf/verifier: Do not limit maximum direct offset into aren=
a map")
>
> (btw, do mention this commit somewhere in the comment in the feature
> detection function in the next revision)
>
>
> which just did this:
>
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21132,11 +21132,6 @@ static int resolve_pseudo_ldimm64(struct
> bpf_verifier_env *env)
>                         } else {
>                                 u32 off =3D insn[1].imm;
>
> -                               if (off >=3D BPF_MAX_VAR_OFF) {
> -                                       verbose(env, "direct value
> offset of %u is not allowed\n", off);
> -                                       return -EINVAL;
> -                               }
> -
>                                 if (!map->ops->map_direct_value_addr) {
>                                         verbose(env, "no direct value
> access support for this map type\n");
>                                         return -EINVAL;
>
>
> Now, setting up ARENA map is quite bothersome (as evidenced by your
> code above), but ARRAY with BPF_F_MMAPABLE flag also allows direct
> value access, so let's use that to do the detection.
>
> Basically, create a small ARRAY map (no BTF required, I think), and
> try to verify a simple program that only does some map access with
> fixed large offset (e.g., at 4GB - 8 offset). With old kernels you'd
> expect this to fail with "direct value offset of %u is not allowed"
> message in the verifier log (you'll need to provide a small log buffer
> in the feature detection function, of course). But on newer ones we'll
> fail on "invalid access to map value pointer, value_size=3D%u off=3D%u".
>
> This relies on verifier log messages, which isn't great, but we can
> adjust one of selftests to validate that libbpf does indeed put offset
> at non-zero offset, as that should always be true for newer kernels.
>
> Does it make sense?
>

Ack, makes total sense.

> pw-bot: cr
>
>
>>  typedef int (*feature_probe_fn)(int /* token_fd */);
>>
>>  static struct kern_feature_cache feature_cache;
>> @@ -581,6 +756,9 @@ static struct kern_feature_desc {
>>         [FEAT_BTF_QMARK_DATASEC] =3D {
>>                 "BTF DATASEC names starting from '?'", probe_kern_btf_qm=
ark_datasec,
>>         },
>> +       [FEAT_ARENA_GLOBAL_RELOC] =3D {
>> +               "Relocatable arena globals support", probe_kern_arena_gl=
obal_reloc,
>
> we don't detect "relocatable arena globals support", we detect if
> ldimm64 allows full range offsets, so call the detector as such (i.e.,
> what you detect, not what for you are doing that).
>
>> +       },
>>  };
>>
>>  bool feat_supported(struct kern_feature_cache *cache, enum kern_feature=
_id feat_id)
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 0c8bf0b5cce4..0aeb740a5f47 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -3009,8 +3009,11 @@ static int init_arena_map_data(struct bpf_object =
*obj, struct bpf_map *map,
>>         memcpy(obj->arena_data, data, data_sz);
>>         obj->arena_data_sz =3D data_sz;
>>
>> -       /* place globals at the end of the arena */
>> -       obj->arena_data_off =3D mmap_sz - data_alloc_sz;
>> +       /* place globals at the end of the arena (if supported) */
>> +       if (kernel_supports(obj, FEAT_ARENA_GLOBAL_RELOC))
>> +               obj->arena_data_off =3D mmap_sz - data_alloc_sz;
>> +       else
>> +               obj->arena_data_off =3D 0;
>>
>>         /* make bpf_map__init_value() work for ARENA maps */
>>         map->mmaped =3D obj->arena_data;
>> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inte=
rnal.h
>> index fc59b21b51b5..e0223a6e4c95 100644
>> --- a/tools/lib/bpf/libbpf_internal.h
>> +++ b/tools/lib/bpf/libbpf_internal.h
>> @@ -392,6 +392,8 @@ enum kern_feature_id {
>>         FEAT_ARG_CTX_TAG,
>>         /* Kernel supports '?' at the front of datasec names */
>>         FEAT_BTF_QMARK_DATASEC,
>> +       /* Kernel supports relocating arena globals to end of the arena =
*/
>> +       FEAT_ARENA_GLOBAL_RELOC,
>>         __FEAT_CNT,
>>  };
>>
>> --
>> 2.49.0
>>
>>

