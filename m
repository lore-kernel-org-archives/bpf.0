Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5AF199D8
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 00:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101322; cv=none; b=b1MisB2fDzlM2ZI8uQCP+eTLC4FG4Ffsr+9QYDvwD46AzdTvB4HzKzja7BTNbG+MehYvVo13Sm0Pvk+UguJCSI+XTvEIJDIHxl6sBSB5y49UYozfH3vRbXRImgpr4frahtYPj9VWgw1ecWOAzxNLVWQAG3Pq/of6fUN6B9SU+a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101322; c=relaxed/simple;
	bh=p+xEJvRwIIEu2Fv9w/1296yT1DHAOLU9SsXrxOPHyR8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rtTYs4gVs8IzkdT++xIZW3pou5zEfaEXqj2OqVg0vAPQCji7oYTN/Klpi5wq/zNZcOCuZEQE7ggjmzHDn+Ax69491ROn0a2hsidz7SBPYjy2ybeSj/7vDAoXEV/OH99vV1JWiT+IqHpcsi12B85WqTf3/JrxCYjqrxnwPdjFy0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gs2hpMu3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gs2hpMu3"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852fdb36a8so28897425e9.2
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 17:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773101319; x=1773706119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFoLd0LlBgii2SJEfVRlsdEAqrVkPOwxke+j0BGisEc=;
        b=Gs2hpMu3ab3d/RLnkjOvYtwRh6Vpm4VQwZRIcozevYabisHCkUXtdRU1T37jubvad7
         XuGAU/C2doxWP7XznmRU/yVRVH+cDxjZ+szzx6haXtgdIys/jK06b65xtDTTFhP75Mkx
         rpGam65RhnPJKVT9XIsaJ2hvfg7z9LVubVF3zNwR0ZnnxYqoGzXGZLdWzX6vHI3gdanj
         aCrE8pPHVCCFlTcAbXuf0T0/VamOHdcoCuGt+P6TmZEpgwgfkUPCWUYCMldo73XS9qPB
         lQxQJgl959MMC1qOOVYpCTAW1z3imEm4R3/u0jwlA5sbrWGhU+3BdTil/UDO9VoEVU64
         R9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773101319; x=1773706119;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZFoLd0LlBgii2SJEfVRlsdEAqrVkPOwxke+j0BGisEc=;
        b=SzzYw7i6SWLjIrUapRXAWCm8AIhOS42feoPaFT+xm7BTbWDVYu9mDASLY0XEUYp83R
         FWekly6l/ffSAgM8XAxUU+1K9DYxwNSWgb7I/4Q2f/YzmfIt+3gTxQ/VbCnZvZsrenF9
         aCjzEGDdWcttT3sLUaTt6vjZjFQOzDSwcw23Yjogi2GSue2Tt9dhYcVUu8PuYl/W/ILi
         FTt++tMEgjXbTcyGiQZ01hZXForUgC63JpIhlpNlyeO40wOHwqnpaX2mZ74GCZi2AHBP
         //ONC+5Spfu4Fe4eO+eZklAm61s+FyD5OKf1r4ZjpV7X+I2U8pVlU2BzGkeKiwfRDAYd
         +RMw==
X-Gm-Message-State: AOJu0YyVvHmJ5ypdqo4fO8vUv9W68Ok/0Bz7OUrQlBpKGTNMURNevmWV
	GxTMVziovaa37FDCuo/IGBvt/Ikq95brp8kBTWR/DevTA/M/CSiV5SEG
X-Gm-Gg: ATEYQzzeuKnfRxIhmqmz3Z8xOfLygB+mUAuUwXktBFuoG+hGKGmDMlhwDHMzsO0TZU4
	HsQEO38yjO8EMO3hRO19zA+olzcn4w0EjP7c9YGtTNXQwMFIpFIare0BizG1zbtDCrZ/dcP4btX
	zse5rdbcL4MxevKORoxWWYScgMjVWxqb7G9t3mWL1P84mS7cELNmW5JWnyh8Fprz9HNlWNs3xkN
	yQPA3XsEtBrOklfci3AuUC11r1yibUMef7QYDvsWbB7uthtMWE3UDuoOlxncy/pJv1rxHIQzyV+
	5jGO/hd73eodRrhAGERAMe3vWroOXmvBqX4O1wToFCNkbr+tCa6N8YqgdfMr6MJRKsOn5TDdal/
	pppKGpnVUx1E4smOwoojAMsabDeQOS+4Zkmq2dpkGQ9XYDRlDtTJSYBOBGqZZFYThbRRQQ5OV+1
	7wdR3LEamXY9KzbuLKCGCqUnwUqI3YnQJDnd6xyQ==
X-Received: by 2002:a05:600c:4fc4:b0:485:40c6:f528 with SMTP id 5b1f17b1804b1-48540c6f743mr40134425e9.30.1773101318666;
        Mon, 09 Mar 2026 17:08:38 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b7f3cdsm31742765e9.14.2026.03.09.17.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:08:38 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, Andrii Nakryiko
 <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 kernel-team@meta.com, DL Linux Open Source Team
 <linux-open-source@crowdstrike.com>
Subject: Re: [External] [PATCH bpf-next v2 1/2] libbpf: Introduce
 bpf_program__clone()
In-Reply-To: <CAOu3gNgW9+C7bOPkt0CGs8d_ad_TNyQ0AKv7_Jfg4=F5PET4ow@mail.gmail.com>
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
 <20260220-veristat_prepare-v2-1-15bff49022a7@meta.com>
 <CAOu3gNgW9+C7bOPkt0CGs8d_ad_TNyQ0AKv7_Jfg4=F5PET4ow@mail.gmail.com>
Date: Tue, 10 Mar 2026 00:08:32 +0000
Message-ID: <878qc0mtq7.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> writes:

Hi,
Thanks for reaching out, I'm providing my own opinion on this, I did not
discuss this with Andrii in depth.

bpf_object__finalize() - you probably do not need this, the mentioned
example of bpf_program__set_type() actually rejects when object is in
LOADED state (you can't mutate loaded program).

To make your dynamic loading/unloading work, you need to keep your
object in the PREPARED state indefinitely. As clone() uses some of the
fields that are destroyed by the post_load_cleanup(). calling
bpf_object__load() in this setup may be unsafe (leaking fd, etc).

We have a precedent with bpf_map__reuse_fd(), bpf_program__set_fd() does
not seem too extreme to me, but it seems like some lifecycle invariants
are changing, as we'll have loaded program in prepared object, which I'm
not 100% sure is a problem right now, but possibly going to break
something.

Also a small detail: bpf_program__clone() does not support PROG_ARRAY
maps (just in case you need that) (see cover letter for details).

> Mykyta and Andrii Hi!
>
> We're evaluating the bpf_object__prepare() +
> bpf_program__clone() API for use in a production BPF
> application that manages hundreds of BPF programs with
> selective (dynamic) loading =E2=80=94 some programs are loaded at
> startup, others loaded/unloaded at runtime based on feature
> configuration.
>
> We have a few questions about the intended usage and
> potential extensions of this API:
>
> 1. Compatibility with bpf_object__load() and object state
>
> After bpf_object__prepare(), the object is in OBJ_PREPARED
> state. Several libbpf APIs (e.g., bpf_program__set_type())
> gate on OBJ_LOADED state.
>
> Is there a recommended way to transition the object to
> OBJ_LOADED after cloning all desired programs? For example,
> would a bpf_object__finalize() or similar API that runs
> post_load_cleanup() and sets OBJ_LOADED be in scope? This
> would allow users to benefit from prepare() + clone() for
> selective loading while keeping the object in a state that
> the rest of libbpf expects. Or, is the new API not intended
> to work with bpf_object in the first place ?
>
> 2. Storing the clone FD back on struct bpf_program
>
> bpf_program__clone() returns a caller-owned FD, but APIs
> like bpf_program__attach() read prog->fd internally.
> Without a way to set the FD back on the program struct, the
> caller must reimplement attach logic (section-type dispatch
> for kprobe, fentry, raw_tp, etc.).
>
> Would a bpf_program__set_fd() setter (similar to the
> existing btf__set_fd()) be acceptable to store the clone FD
> back, making bpf_program__attach() and related APIs usable
> with cloned programs?
>
> 3. Use case: selective program loading from a single BPF
>  object
>
> Our use case involves a single large BPF object (skeleton)
> with hundreds of programs where a subset is loaded at
> startup and others are loaded/unloaded dynamically based on
> runtime configuration. The current approach requires either:
> - Loading all programs upfront (wasteful), or
> - Maintaining out-of-tree patches to libbpf for selective
> loading
>
> Last year we made an attempt to upstream our solution to
> this use case to libbpf[1] but Andrii pointed out how our
> approach was problematic for upstream. He then proposed
> splitting bpf_object__load() into two steps:
> bpf_object__prepare() (creates maps, loads BTF, does
> relocations, produces final program instructions) and then
> bpf_object__load().  We are trying to follow up on his
> input and become more upstream compliant.
>
> The prepare() + clone() API seems similiar to this,
> but the questions above about object state and FD ownership
> are the main gaps for production adoption. Are there plans
> to address these in future revisions, or is this
> intentionally scoped to testing/tooling use cases only?
>
> Thanks,
> Andrey
>
> [1] -https://lore.kernel.org/all/20250122215206.59859-1-slava.imameev@cro=
wdstrike.com/t/#m93ec917b3dfe3115be2a4b6439e2c649c791686d
>
> On Fri, Feb 20, 2026 at 2:18=E2=80=AFPM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Add bpf_program__clone() API that loads a single BPF program from a
>> prepared BPF object into the kernel, returning a file descriptor owned
>> by the caller.
>>
>> After bpf_object__prepare(), callers can use bpf_program__clone() to
>> load individual programs with custom bpf_prog_load_opts, instead of
>> loading all programs at once via bpf_object__load(). Non-zero fields in
>> opts override the defaults derived from the program and object
>> internals; passing NULL opts populates everything automatically.
>>
>> Internally, bpf_program__clone() resolves BTF-based attach targets
>> (attach_btf_id, attach_btf_obj_fd) and the sleepable flag, fills
>> func/line info, fd_array, license, and kern_version from the
>> prepared object before calling bpf_prog_load().
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>  tools/lib/bpf/libbpf.c   | 64 +++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  tools/lib/bpf/libbpf.h   | 17 +++++++++++++
>>  tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!!BmdzS3_=
lV9HdKG8!3OeUmMPxKbEw0Wl_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfaqSd4n0N6UokYq=
OuQporDXrIKYc3k7dvu4Rel1BiJSjA99yzJZk$  |  1 +
>>  3 files changed, 82 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 0c8bf0b5cce4..4b084bda3f47 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -9793,6 +9793,70 @@ __u32 bpf_program__line_info_cnt(const struct bpf=
_program *prog)
>>         return prog->line_info_cnt;
>>  }
>>
>> +int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_=
load_opts *opts)
>> +{
>> +       LIBBPF_OPTS(bpf_prog_load_opts, attr);
>> +       struct bpf_prog_load_opts *pattr =3D &attr;
>> +       struct bpf_object *obj;
>> +       int err, fd;
>> +
>> +       if (!prog)
>> +               return libbpf_err(-EINVAL);
>> +
>> +       if (!OPTS_VALID(opts, bpf_prog_load_opts))
>> +               return libbpf_err(-EINVAL);
>> +
>> +       obj =3D prog->obj;
>> +       if (obj->state < OBJ_PREPARED)
>> +               return libbpf_err(-EINVAL);
>> +
>> +       /* Copy caller opts, fall back to prog/object defaults */
>> +       OPTS_SET(pattr, expected_attach_type,
>> +                OPTS_GET(opts, expected_attach_type, 0) ?: prog->expect=
ed_attach_type);
>> +       OPTS_SET(pattr, attach_btf_id, OPTS_GET(opts, attach_btf_id, 0) =
?: prog->attach_btf_id);
>> +       OPTS_SET(pattr, attach_btf_obj_fd,
>> +                OPTS_GET(opts, attach_btf_obj_fd, 0) ?: prog->attach_bt=
f_obj_fd);
>> +       OPTS_SET(pattr, attach_prog_fd, OPTS_GET(opts, attach_prog_fd, 0=
) ?: prog->attach_prog_fd);
>> +       OPTS_SET(pattr, prog_flags, OPTS_GET(opts, prog_flags, 0) ?: pro=
g->prog_flags);
>> +       OPTS_SET(pattr, prog_ifindex, OPTS_GET(opts, prog_ifindex, 0) ?:=
 prog->prog_ifindex);
>> +       OPTS_SET(pattr, kern_version, OPTS_GET(opts, kern_version, 0) ?:=
 obj->kern_version);
>> +       OPTS_SET(pattr, fd_array, OPTS_GET(opts, fd_array, NULL) ?: obj-=
>fd_array);
>> +       OPTS_SET(pattr, token_fd, OPTS_GET(opts, token_fd, 0) ?: obj->to=
ken_fd);
>> +       if (attr.token_fd)
>> +               attr.prog_flags |=3D BPF_F_TOKEN_FD;
>> +
>> +       /* BTF func/line info */
>> +       if (obj->btf && btf__fd(obj->btf) >=3D 0) {
>> +               OPTS_SET(pattr, prog_btf_fd, OPTS_GET(opts, prog_btf_fd,=
 0) ?: btf__fd(obj->btf));
>> +               OPTS_SET(pattr, func_info, OPTS_GET(opts, func_info, NUL=
L) ?: prog->func_info);
>> +               OPTS_SET(pattr, func_info_cnt,
>> +                        OPTS_GET(opts, func_info_cnt, 0) ?: prog->func_=
info_cnt);
>> +               OPTS_SET(pattr, func_info_rec_size,
>> +                        OPTS_GET(opts, func_info_rec_size, 0) ?: prog->=
func_info_rec_size);
>> +               OPTS_SET(pattr, line_info, OPTS_GET(opts, line_info, NUL=
L) ?: prog->line_info);
>> +               OPTS_SET(pattr, line_info_cnt,
>> +                        OPTS_GET(opts, line_info_cnt, 0) ?: prog->line_=
info_cnt);
>> +               OPTS_SET(pattr, line_info_rec_size,
>> +                        OPTS_GET(opts, line_info_rec_size, 0) ?: prog->=
line_info_rec_size);
>> +       }
>> +
>> +       OPTS_SET(pattr, log_buf, OPTS_GET(opts, log_buf, NULL));
>> +       OPTS_SET(pattr, log_size, OPTS_GET(opts, log_size, 0));
>> +       OPTS_SET(pattr, log_level, OPTS_GET(opts, log_level, 0));
>> +
>> +       /* Resolve BTF attach targets, set sleepable/XDP flags, etc. */
>> +       if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
>> +               err =3D prog->sec_def->prog_prepare_load_fn(prog, pattr,=
 prog->sec_def->cookie);
>> +               if (err)
>> +                       return libbpf_err(err);
>> +       }
>> +
>> +       fd =3D bpf_prog_load(prog->type, prog->name, obj->license, prog-=
>insns, prog->insns_cnt,
>> +                          pattr);
>> +
>> +       return libbpf_err(fd);
>> +}
>> +
>>  #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {                   =
    \
>>         .sec =3D (char *)sec_pfx,                                       =
      \
>>         .prog_type =3D BPF_PROG_TYPE_##ptype,                           =
      \
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index dfc37a615578..0be34852350f 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -2021,6 +2021,23 @@ LIBBPF_API int libbpf_register_prog_handler(const=
 char *sec,
>>   */
>>  LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
>>
>> +/**
>> + * @brief **bpf_program__clone()** loads a single BPF program from a pr=
epared
>> + * BPF object into the kernel, returning its file descriptor.
>> + *
>> + * The BPF object must have been previously prepared with
>> + * **bpf_object__prepare()**. If @opts is provided, any non-zero field
>> + * overrides the defaults derived from the program/object internals.
>> + * If @opts is NULL, all fields are populated automatically.
>> + *
>> + * The returned FD is owned by the caller and must be closed with close=
().
>> + *
>> + * @param prog BPF program from a prepared object
>> + * @param opts Optional load options; non-zero fields override defaults
>> + * @return program FD (>=3D 0) on success; negative error code on failu=
re
>> + */
>> +LIBBPF_API int bpf_program__clone(struct bpf_program *prog, const struc=
t bpf_prog_load_opts *opts);
>> +
>>  #ifdef __cplusplus
>>  } /* extern "C" */
>>  #endif
>> diff --git a/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map=
__;!!BmdzS3_lV9HdKG8!3OeUmMPxKbEw0Wl_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfaq=
Sd4n0N6UokYqOuQporDXrIKYc3k7dvu4Rel1BiJSjA99yzJZk$  b/tools/lib/bpf/https:/=
/urldefense.com/v3/__http://libbpf.map__;!!BmdzS3_lV9HdKG8!3OeUmMPxKbEw0Wl_=
ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfaqSd4n0N6UokYqOuQporDXrIKYc3k7dvu4Rel1B=
iJSjA99yzJZk$
>> index d18fbcea7578..e727a54e373a 100644
>> --- a/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!!Bm=
dzS3_lV9HdKG8!3OeUmMPxKbEw0Wl_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfaqSd4n0N6=
UokYqOuQporDXrIKYc3k7dvu4Rel1BiJSjA99yzJZk$
>> +++ b/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!!Bm=
dzS3_lV9HdKG8!3OeUmMPxKbEw0Wl_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfaqSd4n0N6=
UokYqOuQporDXrIKYc3k7dvu4Rel1BiJSjA99yzJZk$
>> @@ -452,6 +452,7 @@ LIBBPF_1.7.0 {
>>                 bpf_map__set_exclusive_program;
>>                 bpf_map__exclusive_program;
>>                 bpf_prog_assoc_struct_ops;
>> +               bpf_program__clone;
>>                 bpf_program__assoc_struct_ops;
>>                 btf__permute;
>>  } LIBBPF_1.6.0;
>>
>> --
>> 2.47.3
>>
>>
