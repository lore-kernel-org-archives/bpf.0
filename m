Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B19D242D65
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782249110; cv=pass; b=hNj4WBASrCLI1A/cc73YXyYyYfCzkcB9jm8YGSMjk5+MrAWI3gcNXy8QIk4l/AWMpzUJ5cpSvBJh/qclQkQ7h5Fl25HbpoILdGyn3GLyksPkl+4O2ciwv0dZkUENgzykZQyB8TgiCkaEBEm9wQcYNrzSON/XKq6/jvp+39zl0JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782249110; c=relaxed/simple;
	bh=jIdDO028WcWYWJdNFPq0qlQvbtOghod/SiGOsGfyG9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SgRbpk8I9mbb4SSsWpYxVg5ATBhdpPRBvP8fV4dzaO/PAom0wvtJK/ttCqme+5+CB6M7d385dEFC1tEIRBqWyZSJPJujcmfHh0nJyLfnWfnTLmmkOudAJ3lUm17FtkOYpvTHEDUBFluQz5KftnGnwx9JDxXufqPoqCeTfN7FVtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FskBBVyE; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FskBBVyE"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c68190ade4so10224375ad.0
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 14:11:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782249109; cv=none;
        d=google.com; s=arc-20240605;
        b=PnjbxV1ivj+phDvvoqs2NtTwLV7sOZ/fZ4OS22B1vtmbhlBxL2rBbNIezJWhf5BpK9
         PXc+1uBNMF6oeAJ5ynIKyissxNo0UjSzaacmGIxaGE2TrW1YkZsYtxOu1dMEoWin8h4f
         59tGrl04rf6A5C9CG99QzOSPWVOQ/Vrx6oNCSZ1r4pobeSdpu59sKRi+QmBmVkXwb5Eo
         X09y7UKKNFAHpOPeBgvVIAMU0ztM7Exz8oMakrT3JCQ+BI0e54BMeCJ212mzT1uXJmJt
         V3PxOhLcJ/Kvru+IHiIGSTTNEs90LCwYUdXKG2OnPvV49IKYuVnGZOBEWj9SMYBDVc2l
         piaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VYKKFJLLthxIqKIgABif56o0+oIG7tIh3IUIZDWsCjw=;
        fh=a+LimC9MOlmrHjONMG2Lf76HOzQxzK6N6yRQMwgAytI=;
        b=lmpQbVnZRPHVVcWbJpUusqQnegjQL2HkOcxvCR0mXg2X9yeQmmx/DHs2KwOfEi4Oyt
         iNwg7SgBNRiUsh8EnfAnEJIP/T53qW8RQ2LhUKFwQCxF5ErAwcRWCcs0J3Bz22Aqm2t9
         hlfh/XTOJqeQL0DvbZMrZUatGCghM8MvFmdsDhnGx/nhFM1eS5C/F5YxOc+FApIt/573
         L9AMDueU/vnnVaI4+J2lqgDY/4osUPqDr/sNETPBV6r5SnE3GhUw/1v+OTbZkmW+jUCS
         OF4wMJZJI+SZPcINdbTI47GJCJVBqNw5uZdX+8ZtBev+zqsecsDsQ7j9dtpGyU4GG1ia
         vboA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782249109; x=1782853909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYKKFJLLthxIqKIgABif56o0+oIG7tIh3IUIZDWsCjw=;
        b=FskBBVyEfF0HFlwUU4crPiZP8NKk8CLaDK5EtteoIxJgBTAJIz/UMK0M1lA9ieFuXI
         QgSaInrbbBfqQDz2KBL0G0lgUNF9xraTwJnQvIcObBFEt5j+Flc0/74F0qw13jQX2euI
         W/HKtBEJy/sV+j+sQaHg/JWM8oFzsAuGC7WfwCMdeHI1Hm5mVXi6DSwOr5J87jJH4wXI
         ONp5hoqnhbYH93XYtm1oIiSAhqQ+AnG8y50Y38BJoJtiN9JqbCvne6U4dRMKmGwP6U/v
         VXkRqgwxp3rcQHvoMGd9co8+sbABKONiWGguylveXa3gJGX0MZOCel5X3xC8eRUHn9ON
         Yhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782249109; x=1782853909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VYKKFJLLthxIqKIgABif56o0+oIG7tIh3IUIZDWsCjw=;
        b=iyCMTSjspRzu7L7py9+E2g9/2ANnKvxWNhMdIRCP5826aOGkOWaEjDaG9wvynYOyyC
         FkaWSZsQLELIPGQ0GKIFS8rNQ2Xbg8Z6XwcF1W9FokMDig3/Y23tMXnevl5zAEt29JQ5
         A1bWCqHnENgyOgcCYXchCJ2pm9v+wZ1G86bcDDgI2PUTmK/VpfrhIoBp7kDyuCxprUIW
         XetZ33jw6loaMYLc4UnAGzHJ6xwvIHfwG3L1LPzjXpYf2bI5agT6UDEYeGFx582+SZF/
         /oEhyBYvwDOe/d7iFEeiUzg0GhNW7CSWlrEF4U6eZUkmFqtWGpihG1tuBveGQm2wF7Xz
         lEJg==
X-Forwarded-Encrypted: i=1; AHgh+RoPcMvNgZ2rGWEWIw+DQw5KG3tLHP/usKJ0GhDdnfhJBmQVl7MZAMWZ+oHgl2IpGjq1R90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYuWGpoZEcjG7pQoPeCjlkYtdAsmT3clpM+nXEMYBF3wmgsBre
	1uTDgxOoBmLkDTq3FOAzo76Cfo/wul3bB2fweomuVWcEcUp9xe2Kp8n+fVjBYJn5ptdHl1Ug+hK
	yaTj93DvkzVAEUY8lyLsKxn/k4ZmV3CQ=
X-Gm-Gg: AfdE7clBaPC1747LsR5R/zJHb3jrS0eZ/F2cnIxZBpY7YGMYSH83gP3jeC3ENXwv0xj
	uBOZ3dIfhXE/NIAtjKpeAZGQxaKFKHGa0XgWATLsNecPPYJf/nImmkyQwVOtGIHai9jZ7w5d5J/
	d5tbPXbxd22RO4vhdlkr27u/gXw8qB0jl5pUrgKR5OQNjSZXxSZAbMjLFaH8Es1OUFQWP1J9dTw
	WNF4kOFA/8l8oq354Pj08Nf9wNVf6fJwowPnJul8sGoPyn+coAfaH9gS/mc6TV3DgoGaz0ljUMy
	LzMAEFIvOob3I/ScMk/QdZkj71Bnfpld32XX2AgGWrk0hy9Cdy1w/JlW2qAm0hWDJdiOjRw8AwZ
	X7CTQ
X-Received: by 2002:a17:902:ea09:b0:2c0:dc5c:9069 with SMTP id
 d9443c01a7336-2c7c3d404d2mr38439425ad.2.1782249108746; Tue, 23 Jun 2026
 14:11:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623142417.275892-1-jolsa@kernel.org> <20260623142417.275892-4-jolsa@kernel.org>
In-Reply-To: <20260623142417.275892-4-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jun 2026 14:11:34 -0700
X-Gm-Features: AVVi8CeAa8-VhWBninFJprxZgOQFnymCp8HQf6uwkvOGqTfz7EHbFdjlzrZUgeo
Message-ID: <CAEf4BzaCnTNo5dmYGRVWGWn+tUCP279Owbg54MuVqQrZTx=rQQ@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 3/3] bpftool: Add tracing_multi link info output
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 7:24=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding bpftool support to show tracing_multi link details,
> the new output looks like:
>
>   # bpftool link
>   ...
>   27: tracing_multi  prog 93
>           attach_type trace_fentry_multi  obj_id 1  count 3
>           btf_id           addr             cookie           func [module=
]
>           91984            ffffffff824f4a24 a                bpf_fentry_t=
est1
>           91986            ffffffff824f6a84 1e               bpf_fentry_t=
est2
>           91987            ffffffff824f6a94 14               bpf_fentry_t=
est3
>           pids test_progs(1462)
>
> Assisted-by: Codex:GPT-5
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/bpf/bpftool/link.c | 137 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 137 insertions(+)
>
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index bdcd717b0348..db780ee39820 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -377,6 +377,25 @@ static __u64 *u64_to_arr(__u64 val)
>         return (__u64 *) u64_to_ptr(val);
>  }
>
> +static __u32 *u64_to_u32_arr(__u64 val)
> +{
> +       return (__u32 *)u64_to_ptr(val);
> +}
> +
> +static struct kernel_sym *find_kernel_sym_by_addr(__u64 addr, bool is_ib=
t_enabled)
> +{
> +       struct kernel_sym *sym;
> +
> +       if (!addr)
> +               return NULL;
> +
> +       sym =3D kernel_syms_search(&dd, addr);
> +       if (!sym && is_ibt_enabled && addr >=3D 4)
> +               sym =3D kernel_syms_search(&dd, addr - 4);

if is_ibt_enabled, can we match addr with kernel_syms_search at all?
I.e., can addr sometimes be resolvable without - 4 adjustment? If not,
why is this not if/else and instead "try this, if not, try that"?

> +
> +       return sym;
> +}
> +
>  static void
>  show_uprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
>  {
> @@ -403,6 +422,47 @@ show_uprobe_multi_json(struct bpf_link_info *info, j=
son_writer_t *wtr)
>         jsonw_end_array(json_wtr);
>  }
>
> +static void
> +show_tracing_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
> +{
> +       bool is_ibt_enabled =3D is_x86_ibt_enabled(), show_symbol;
> +       __u32 i;
> +
> +       if (!dd.sym_count)
> +               kernel_syms_load(&dd);
> +       show_symbol =3D !!dd.sym_count;
> +
> +       show_link_attach_type_json(info->tracing_multi.attach_type, wtr);
> +       jsonw_uint_field(wtr, "func_cnt", info->tracing_multi.count);
> +       jsonw_uint_field(wtr, "obj_id", info->tracing_multi.obj_id);
> +       jsonw_name(wtr, "funcs");
> +
> +       jsonw_start_array(wtr);
> +
> +       for (i =3D 0; i < info->tracing_multi.count; i++) {
> +               __u64 addr =3D u64_to_arr(info->tracing_multi.addrs)[i];
> +               struct kernel_sym *sym;
> +
> +               sym =3D show_symbol ? find_kernel_sym_by_addr(addr, is_ib=
t_enabled) : NULL;
> +
> +               jsonw_start_object(wtr);
> +               jsonw_uint_field(wtr, "id", u64_to_u32_arr(info->tracing_=
multi.ids)[i]);

nit, here and for cookies, do the cast outside of the loop into local
variable? seems cleaner as an approach

> +               jsonw_uint_field(wtr, "addr", addr);
> +               if (sym) {
> +                       jsonw_string_field(wtr, "func", sym->name);
> +                       if (sym->module[0] =3D=3D '\0') {
> +                               jsonw_name(wtr, "module");
> +                               jsonw_null(wtr);

just curious, is it cleaner to have "module: null" instead of just not
emitting "module:" field at all?

> +                       } else {
> +                               jsonw_string_field(wtr, "module", sym->mo=
dule);
> +                       }
> +               }
> +               jsonw_uint_field(wtr, "cookie", u64_to_arr(info->tracing_=
multi.cookies)[i]);
> +               jsonw_end_object(wtr);
> +       }
> +       jsonw_end_array(wtr);
> +}
> +
>  static void
>  show_perf_event_kprobe_json(struct bpf_link_info *info, json_writer_t *w=
tr)
>  {
> @@ -589,6 +649,9 @@ static int show_link_close_json(int fd, struct bpf_li=
nk_info *info)
>         case BPF_LINK_TYPE_UPROBE_MULTI:
>                 show_uprobe_multi_json(info, json_wtr);
>                 break;
> +       case BPF_LINK_TYPE_TRACING_MULTI:
> +               show_tracing_multi_json(info, json_wtr);
> +               break;
>         case BPF_LINK_TYPE_PERF_EVENT:
>                 switch (info->perf_event.type) {
>                 case BPF_PERF_EVENT_EVENT:
> @@ -833,6 +896,42 @@ static void show_uprobe_multi_plain(struct bpf_link_=
info *info)
>         }
>  }
>
> +static void show_tracing_multi_plain(struct bpf_link_info *info)
> +{
> +       bool is_ibt_enabled =3D is_x86_ibt_enabled(), show_symbol;
> +       __u32 i;
> +
> +       if (!info->tracing_multi.count)
> +               return;
> +
> +       if (!dd.sym_count)
> +               kernel_syms_load(&dd);
> +       show_symbol =3D !!dd.sym_count;
> +
> +       printf("\n\t");
> +       show_link_attach_type_plain(info->tracing_multi.attach_type);
> +       printf("obj_id %u  ", info->tracing_multi.obj_id);
> +       printf("count %u  ", info->tracing_multi.count);
> +
> +       printf("\n\t%-16s %-16s %-16s %s",
> +              "btf_id", "addr", "cookie", "func [module]");
> +       for (i =3D 0; i < info->tracing_multi.count; i++) {
> +               __u64 addr =3D u64_to_arr(info->tracing_multi.addrs)[i];
> +               struct kernel_sym *sym;
> +
> +               sym =3D show_symbol ? find_kernel_sym_by_addr(addr, is_ib=
t_enabled) : NULL;
> +
> +               printf("\n\t%-16u %016llx %-16llx",
> +                      u64_to_u32_arr(info->tracing_multi.ids)[i],
> +                      addr, u64_to_arr(info->tracing_multi.cookies)[i]);

As I mentioned, it surprised me that we emit cookie as hex. Kernel
doesn't in fdinfo output. And at least in my experience cookie is some
small compact index into some additional lookup array, so decimal
makes most sense. I see now that we have hex for uprobe_multi, but
decimal for perf link, so ugh, goodbye consistency. But still, decimal
will be much more useful in practice, IMO.

> +               if (sym) {
> +                       printf(" %s", sym->name);
> +                       if (sym->module[0] !=3D '\0')
> +                               printf(" [%s]", sym->module);
> +               }
> +       }
> +}
> +
>  static void show_perf_event_kprobe_plain(struct bpf_link_info *info)
>  {
>         const char *buf;
> @@ -989,6 +1088,9 @@ static int show_link_close_plain(int fd, struct bpf_=
link_info *info)
>         case BPF_LINK_TYPE_UPROBE_MULTI:
>                 show_uprobe_multi_plain(info);
>                 break;
> +       case BPF_LINK_TYPE_TRACING_MULTI:
> +               show_tracing_multi_plain(info);
> +               break;
>         case BPF_LINK_TYPE_PERF_EVENT:
>                 switch (info->perf_event.type) {
>                 case BPF_PERF_EVENT_EVENT:
> @@ -1029,6 +1131,7 @@ static int show_link_close_plain(int fd, struct bpf=
_link_info *info)
>  static int do_show_link(int fd)
>  {
>         __u64 *ref_ctr_offsets =3D NULL, *offsets =3D NULL, *cookies =3D =
NULL;
> +       __u32 *ids =3D NULL;
>         struct bpf_link_info info;
>         __u32 len =3D sizeof(info);
>         char path_buf[PATH_MAX];
> @@ -1114,6 +1217,39 @@ static int do_show_link(int fd)
>                         goto again;
>                 }
>         }
> +       if (info.type =3D=3D BPF_LINK_TYPE_TRACING_MULTI &&
> +           !info.tracing_multi.ids) {

why wrap?

> +               count =3D info.tracing_multi.count;
> +               if (count) {
> +                       ids =3D calloc(count, sizeof(__u32));
> +                       if (!ids) {
> +                               p_err("mem alloc failed");
> +                               close(fd);
> +                               return -ENOMEM;
> +                       }
> +                       info.tracing_multi.ids =3D ptr_to_u64(ids);
> +
> +                       addrs =3D calloc(count, sizeof(__u64));
> +                       if (!addrs) {
> +                               p_err("mem alloc failed");
> +                               free(ids);
> +                               close(fd);
> +                               return -ENOMEM;
> +                       }
> +                       info.tracing_multi.addrs =3D ptr_to_u64(addrs);
> +
> +                       cookies =3D calloc(count, sizeof(__u64));
> +                       if (!cookies) {
> +                               p_err("mem alloc failed");
> +                               free(addrs);
> +                               free(ids);
> +                               close(fd);
> +                               return -ENOMEM;
> +                       }

ugh... do three calloc()s in a row, check that all succeeded, if not -
free and close(fd)? shorter and just as good

> +                       info.tracing_multi.cookies =3D ptr_to_u64(cookies=
);
> +                       goto again;
> +               }
> +       }
>         if (info.type =3D=3D BPF_LINK_TYPE_PERF_EVENT) {
>                 switch (info.perf_event.type) {
>                 case BPF_PERF_EVENT_TRACEPOINT:
> @@ -1153,6 +1289,7 @@ static int do_show_link(int fd)
>         free(cookies);
>         free(offsets);
>         free(addrs);
> +       free(ids);
>         close(fd);
>         return 0;
>  }
> --
> 2.54.0
>
