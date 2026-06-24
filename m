Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63788370AED
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782300727; cv=none; b=D1qUFFFUjNyclu2c4PK8qeAfMR+wbTvAH0aHAlNwvRfTgith4oJ8XrwlxLX/69FbYtiftQm8uynzjBs9Kgja9FbxU3Pvn3fob50HpvANqlyoCF+SfYy0lAQjyLh+quf3fb4l+EHQgitNvIUWW0kb1AzevAnwreZz8QWc14zuPec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782300727; c=relaxed/simple;
	bh=YvSM8pnFbxuSwAi30PgGRYhXBcb2L5toaafaAdfDhw8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7uGxtgZ3rqTnqdkk60vL+bzMOeCHeW+9THdBvJ+luPOla4Hpd6YskP+v3k+EFOpOVLtlk95UzHfP53+1sOz1aYGvFtAHbzTIaoaMphhRr88ISi79ILGHuPT9mjvafDRuAwE0urNYYcawLrIdgKVg/KNFtZ/jdMFfrDjrEXLXg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIF0hDGJ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIF0hDGJ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-463b2f6fc9dso1055948f8f.2
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 04:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782300724; x=1782905524; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sjVeJSoMDec/+ZIyIKAxSgNSUrLIMLUS71Qvnw5ri3g=;
        b=FIF0hDGJT+fnw6B0LMOjwtEl4LmMx+NhXzTvWK277oiGkq+EGwMx1cHbcxWZO0Z00U
         SeFA+4u3eFTRRAv8CITsuvJS1+WtI35l7zqS+gy0ObbXiGhhKDMLL2m8tQFoPjM3Wnbl
         0HGU/yN/zFwhwdZtRKWK0fOy4F9+C+5JSKUcuJy5S+896nXJan25JXjl2ttUQrbSY1tW
         +5lOG5x8JPOu6BHOb9RHX3Byw0IiRLZKcW8BkSOTnrd7WfUpopHIGaQ/K2eUajkFGowS
         RK4jz5diVUS5bW8nkGQm0+jLo8q75SoZQPzkPVerwlcBO3UmL9IZjcOJlOIi2L37oBln
         iZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782300724; x=1782905524;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sjVeJSoMDec/+ZIyIKAxSgNSUrLIMLUS71Qvnw5ri3g=;
        b=bjGxYQsNOZnb0PQ6OrQEblbIwunVvwQ5cSRQRVOuE+Bm3u1tyqQOqs6gfilyu72LS2
         kW8txjtYYY9lY8BJV/OgLMW5MDqvBUSP1cpxy/KWg4ZfPyjnRHZwFwRAZqbz9kYbaJxU
         1p6qH9Df7YHapeYCBB3qDoGMWOYM8bV+baZR7XzosCuPozXPT9KdnInVyiar6ipJhR+8
         AWHbHL1IjBpygDTfx1S7TA8xqzzyX5IQI8JC8zSPRHfuxI4U6nXWWMiEDUlQcIAVhigi
         cv6wSkqjozA26QvDLbh2JrTMcI7eayMCSYbjZGe6ylvHa44K5Qm7QMHxC4RK39aKOIyS
         dlmQ==
X-Forwarded-Encrypted: i=1; AHgh+RoDWrJfT9wHKaEs0OJhcfstayKxxHg0EQzb+x0DI8Mx6rhcoJd7l4G9XGMM6V9yq4y6kTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpOb5kd8FMU3zMVbMD3NYrMmAMgurt2aR7vdgxkNWYT1CeXmDh
	30ESsA/m87Vqp5xQER7mtlLJ3ZF3pTDgYwoqQGaim5SlKbFZLKKlQKTS
X-Gm-Gg: AfdE7ckRFRbI6lqgKTFq7zkW9twSg8hD6wuPiG9qoEqj2MSU51g8QSCV/E1EcnBxAow
	lgiC298ko0aWHUkDr0fxEzDaJ+5a/DxjMDM+gEXZShp0JKeMIbTscaRwk0ufuINqmbbzo9Ex91z
	AAioz4ElEa5YA570/B2EEt98L55ApkkQPa+vwbo/TDf2tjzsONPjbtWhdHoolh6gcyLT0wWpJfs
	n6fmBgu8dOp+mkLserq4Ur9ZPTGUtTqSax63IqyRwX+GnmxoHWMX8MB07tiOXsFAsp+xihipCx1
	h/3DF9UuJhAxu3ZZpJgCJD7NQnSezMbGhOnbSXVEszHMfBSe5TJ1hoDB7hEQOYf84oJIG2J30GV
	7F9BTM1kdjEEeUm8Vwm4g2qJnyH5cn7QKkS16sRKq6jAPLMypliHfh3gqUyOWnACTxOQtapC70f
	AX
X-Received: by 2002:a05:6000:4313:b0:452:6aaf:76cb with SMTP id ffacd0b85a97d-46c0951d960mr5215888f8f.1.1782300723443;
        Wed, 24 Jun 2026 04:32:03 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1b754471sm5982646f8f.0.2026.06.24.04.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 04:32:02 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Jun 2026 13:32:01 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCHv2 bpf-next 3/3] bpftool: Add tracing_multi link info
 output
Message-ID: <ajvAMSeIxsHGBXOw@krava>
References: <20260623142417.275892-1-jolsa@kernel.org>
 <20260623142417.275892-4-jolsa@kernel.org>
 <CAEf4BzaCnTNo5dmYGRVWGWn+tUCP279Owbg54MuVqQrZTx=rQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaCnTNo5dmYGRVWGWn+tUCP279Owbg54MuVqQrZTx=rQQ@mail.gmail.com>

On Tue, Jun 23, 2026 at 02:11:34PM -0700, Andrii Nakryiko wrote:
> On Tue, Jun 23, 2026 at 7:24 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding bpftool support to show tracing_multi link details,
> > the new output looks like:
> >
> >   # bpftool link
> >   ...
> >   27: tracing_multi  prog 93
> >           attach_type trace_fentry_multi  obj_id 1  count 3
> >           btf_id           addr             cookie           func [module]
> >           91984            ffffffff824f4a24 a                bpf_fentry_test1
> >           91986            ffffffff824f6a84 1e               bpf_fentry_test2
> >           91987            ffffffff824f6a94 14               bpf_fentry_test3
> >           pids test_progs(1462)
> >
> > Assisted-by: Codex:GPT-5
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/bpf/bpftool/link.c | 137 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 137 insertions(+)
> >
> > diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> > index bdcd717b0348..db780ee39820 100644
> > --- a/tools/bpf/bpftool/link.c
> > +++ b/tools/bpf/bpftool/link.c
> > @@ -377,6 +377,25 @@ static __u64 *u64_to_arr(__u64 val)
> >         return (__u64 *) u64_to_ptr(val);
> >  }
> >
> > +static __u32 *u64_to_u32_arr(__u64 val)
> > +{
> > +       return (__u32 *)u64_to_ptr(val);
> > +}
> > +
> > +static struct kernel_sym *find_kernel_sym_by_addr(__u64 addr, bool is_ibt_enabled)
> > +{
> > +       struct kernel_sym *sym;
> > +
> > +       if (!addr)
> > +               return NULL;
> > +
> > +       sym = kernel_syms_search(&dd, addr);
> > +       if (!sym && is_ibt_enabled && addr >= 4)
> > +               sym = kernel_syms_search(&dd, addr - 4);
> 
> if is_ibt_enabled, can we match addr with kernel_syms_search at all?
> I.e., can addr sometimes be resolvable without - 4 adjustment? If not,
> why is this not if/else and instead "try this, if not, try that"?

I followed the symbol_matches_target logic and assumed we could have functions
with and without endbr instruction at the entry.. but I can't find any example
of such traceable function

> 
> > +
> > +       return sym;
> > +}
> > +
> >  static void
> >  show_uprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
> >  {
> > @@ -403,6 +422,47 @@ show_uprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
> >         jsonw_end_array(json_wtr);
> >  }
> >
> > +static void
> > +show_tracing_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
> > +{
> > +       bool is_ibt_enabled = is_x86_ibt_enabled(), show_symbol;
> > +       __u32 i;
> > +
> > +       if (!dd.sym_count)
> > +               kernel_syms_load(&dd);
> > +       show_symbol = !!dd.sym_count;
> > +
> > +       show_link_attach_type_json(info->tracing_multi.attach_type, wtr);
> > +       jsonw_uint_field(wtr, "func_cnt", info->tracing_multi.count);
> > +       jsonw_uint_field(wtr, "obj_id", info->tracing_multi.obj_id);
> > +       jsonw_name(wtr, "funcs");
> > +
> > +       jsonw_start_array(wtr);
> > +
> > +       for (i = 0; i < info->tracing_multi.count; i++) {
> > +               __u64 addr = u64_to_arr(info->tracing_multi.addrs)[i];
> > +               struct kernel_sym *sym;
> > +
> > +               sym = show_symbol ? find_kernel_sym_by_addr(addr, is_ibt_enabled) : NULL;
> > +
> > +               jsonw_start_object(wtr);
> > +               jsonw_uint_field(wtr, "id", u64_to_u32_arr(info->tracing_multi.ids)[i]);
> 
> nit, here and for cookies, do the cast outside of the loop into local
> variable? seems cleaner as an approach

ok

> 
> > +               jsonw_uint_field(wtr, "addr", addr);
> > +               if (sym) {
> > +                       jsonw_string_field(wtr, "func", sym->name);
> > +                       if (sym->module[0] == '\0') {
> > +                               jsonw_name(wtr, "module");
> > +                               jsonw_null(wtr);
> 
> just curious, is it cleaner to have "module: null" instead of just not
> emitting "module:" field at all?

I followed what we do for kprobe_multi, not sure what's preffered,
but I think it's better to be consistent.. at least somewhere ;-)

> 
> > +                       } else {
> > +                               jsonw_string_field(wtr, "module", sym->module);
> > +                       }
> > +               }
> > +               jsonw_uint_field(wtr, "cookie", u64_to_arr(info->tracing_multi.cookies)[i]);
> > +               jsonw_end_object(wtr);
> > +       }
> > +       jsonw_end_array(wtr);
> > +}
> > +
> >  static void
> >  show_perf_event_kprobe_json(struct bpf_link_info *info, json_writer_t *wtr)
> >  {
> > @@ -589,6 +649,9 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
> >         case BPF_LINK_TYPE_UPROBE_MULTI:
> >                 show_uprobe_multi_json(info, json_wtr);
> >                 break;
> > +       case BPF_LINK_TYPE_TRACING_MULTI:
> > +               show_tracing_multi_json(info, json_wtr);
> > +               break;
> >         case BPF_LINK_TYPE_PERF_EVENT:
> >                 switch (info->perf_event.type) {
> >                 case BPF_PERF_EVENT_EVENT:
> > @@ -833,6 +896,42 @@ static void show_uprobe_multi_plain(struct bpf_link_info *info)
> >         }
> >  }
> >
> > +static void show_tracing_multi_plain(struct bpf_link_info *info)
> > +{
> > +       bool is_ibt_enabled = is_x86_ibt_enabled(), show_symbol;
> > +       __u32 i;
> > +
> > +       if (!info->tracing_multi.count)
> > +               return;
> > +
> > +       if (!dd.sym_count)
> > +               kernel_syms_load(&dd);
> > +       show_symbol = !!dd.sym_count;
> > +
> > +       printf("\n\t");
> > +       show_link_attach_type_plain(info->tracing_multi.attach_type);
> > +       printf("obj_id %u  ", info->tracing_multi.obj_id);
> > +       printf("count %u  ", info->tracing_multi.count);
> > +
> > +       printf("\n\t%-16s %-16s %-16s %s",
> > +              "btf_id", "addr", "cookie", "func [module]");
> > +       for (i = 0; i < info->tracing_multi.count; i++) {
> > +               __u64 addr = u64_to_arr(info->tracing_multi.addrs)[i];
> > +               struct kernel_sym *sym;
> > +
> > +               sym = show_symbol ? find_kernel_sym_by_addr(addr, is_ibt_enabled) : NULL;
> > +
> > +               printf("\n\t%-16u %016llx %-16llx",
> > +                      u64_to_u32_arr(info->tracing_multi.ids)[i],
> > +                      addr, u64_to_arr(info->tracing_multi.cookies)[i]);
> 
> As I mentioned, it surprised me that we emit cookie as hex. Kernel
> doesn't in fdinfo output. And at least in my experience cookie is some
> small compact index into some additional lookup array, so decimal
> makes most sense. I see now that we have hex for uprobe_multi, but
> decimal for perf link, so ugh, goodbye consistency. But still, decimal
> will be much more useful in practice, IMO.

agreed

> 
> > +               if (sym) {
> > +                       printf(" %s", sym->name);
> > +                       if (sym->module[0] != '\0')
> > +                               printf(" [%s]", sym->module);
> > +               }
> > +       }
> > +}
> > +
> >  static void show_perf_event_kprobe_plain(struct bpf_link_info *info)
> >  {
> >         const char *buf;
> > @@ -989,6 +1088,9 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
> >         case BPF_LINK_TYPE_UPROBE_MULTI:
> >                 show_uprobe_multi_plain(info);
> >                 break;
> > +       case BPF_LINK_TYPE_TRACING_MULTI:
> > +               show_tracing_multi_plain(info);
> > +               break;
> >         case BPF_LINK_TYPE_PERF_EVENT:
> >                 switch (info->perf_event.type) {
> >                 case BPF_PERF_EVENT_EVENT:
> > @@ -1029,6 +1131,7 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
> >  static int do_show_link(int fd)
> >  {
> >         __u64 *ref_ctr_offsets = NULL, *offsets = NULL, *cookies = NULL;
> > +       __u32 *ids = NULL;
> >         struct bpf_link_info info;
> >         __u32 len = sizeof(info);
> >         char path_buf[PATH_MAX];
> > @@ -1114,6 +1217,39 @@ static int do_show_link(int fd)
> >                         goto again;
> >                 }
> >         }
> > +       if (info.type == BPF_LINK_TYPE_TRACING_MULTI &&
> > +           !info.tracing_multi.ids) {
> 
> why wrap?

I followed the previous code style

> 
> > +               count = info.tracing_multi.count;
> > +               if (count) {
> > +                       ids = calloc(count, sizeof(__u32));
> > +                       if (!ids) {
> > +                               p_err("mem alloc failed");
> > +                               close(fd);
> > +                               return -ENOMEM;
> > +                       }
> > +                       info.tracing_multi.ids = ptr_to_u64(ids);
> > +
> > +                       addrs = calloc(count, sizeof(__u64));
> > +                       if (!addrs) {
> > +                               p_err("mem alloc failed");
> > +                               free(ids);
> > +                               close(fd);
> > +                               return -ENOMEM;
> > +                       }
> > +                       info.tracing_multi.addrs = ptr_to_u64(addrs);
> > +
> > +                       cookies = calloc(count, sizeof(__u64));
> > +                       if (!cookies) {
> > +                               p_err("mem alloc failed");
> > +                               free(addrs);
> > +                               free(ids);
> > +                               close(fd);
> > +                               return -ENOMEM;
> > +                       }
> 
> ugh... do three calloc()s in a row, check that all succeeded, if not -
> free and close(fd)? shorter and just as good

ah right.. I guess I followed the previous kprobe/uprobe code style,
but as you said, we can simplify the error path, will change

thanks,
jirka
