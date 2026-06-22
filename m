Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7012427603C
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 10:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124558; cv=none; b=nTPYzYeKv/qo28+RghG7boYM0z+O0T15S3OUV/xc02o8wcUEG4OnpfGscbR4JKCuhd3YNQnLYKscbK+JjjmkdVfYYjXHJKx//xbp4jlzfd5jqmMDWjJUt5MGytnQoJ3gBIwbuF7xePkYNQP9HvTDAuRqL4/qWcS4T7moD4Vj7Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124558; c=relaxed/simple;
	bh=joqOw3r3l/AriAm5lzRC9enLA0DafnLfJyrYSdfa6sc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7DUWOYL6RyF37arMqkDbE/0Am9AEQSHb8K0dBUqlUMTytHgAUL41SYUh0EMHOEdHdvQfPQHCVnl5/60cPJKFMlkgwEvKpUTv3hdt7TR9MHMMzrDj9JTOlqHS26Urgt1imwaeVyiXi9CH7OuRzwV5ANBH8mv1ZXjeU793z8VL0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzY2S+bT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzY2S+bT"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b64c8311so40421865e9.3
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 03:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782124555; x=1782729355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aZ6i2HAhckG7aWM48BWlDJy30pPlvkRBinVIai6SZpM=;
        b=mzY2S+bTSgnNEt3pPem/deeydQwq3zikNGJMDToRmc5UHD8mi00w4h9ujbQ1fwhqqG
         W5nwc3kkduV3VmB1eaO2B9PdSXXHfn9/rbuiiKVWR90xMOSLIfpHxpUMnb/PUVvjMZys
         6k6Z2yNYOUzIBc2sKu//7YlG+9Nni7t1AEbl0GoLMjvOcsTk2Ngdjun2M3Re0Q4y9Bja
         DNXFiP+vhV46bSpAZSU+tE/9VCSnyLT5RdCdZ8gkTWerulNDzPwn5blR+Iz8tnvBHbVn
         B9XkPduWh0ze/sStDpuprZv3bcn6qPsNWYOqVvK4poV6HeUHgGw33pEk4rGwMZYbsoqm
         +C+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782124555; x=1782729355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZ6i2HAhckG7aWM48BWlDJy30pPlvkRBinVIai6SZpM=;
        b=DTcFBva48qgLmcI6G+M4jX6M3sjvagwUuzLYLWNcxwupHIcVeVbrJ5QnGC37NyvIbk
         6Okgioehz+oTfCacEUeli5lm87XWqsuDKEB6FRyCqNWDMCjjRfy5xPh7bd/Y86Idb6vl
         rH5FozEfFnLuEQ/G0e/G6hlsocYByKBNxEY0OaVRkmiFx5jahrkcz10HsIWQ6HuVh07S
         1w2piKWYAvCISHocFcKk2J7j77WAK9wThgeMi3scmh2OPgQ2SJjYPnUcQFvjXjdhI1e+
         go+fk+rwWC/350daz988GjNXWpbFXtM2NIsL2/HplrJ9CK7cufXUGiDiZX9g0s6yJz2f
         O8jw==
X-Gm-Message-State: AOJu0YyxfGFjqhit5DGJqfvSitU7czyP6hlu6e0x1qHU5LZ236aV8fD0
	n4qVyWk1IdaUpVO5gdQIc+6qas7fIkZVG0CeEDqh97PFPFq9HKPJqTHE
X-Gm-Gg: AfdE7cl9xrG3mC4boeyTrclHJnwkTGaJjM3hy+ykTe+bex+3kgEuaDIVWmqLBoVftbA
	DmPmXNfMO+wkDGGnyCu2NLyvl4Lopj1JPW3mZYVMLiwgV6cJLVnv5wsIAZNkPQ8jc11SQzwCMJo
	OE3xBfripU8LlSofyUf9c9Oc0mrxfPw0PG86nHQ1/CmXW/NCd0B737l/jZvzSSZXfYZuKBRztDM
	O0/b1KwdB4ZgQgNHzUfLcp+0E01wfxs3kF5T2OdDn0Su24oo1uxhUcSt0MohqG1eyY7Jt/Bofis
	coFD7qjgnw3CT1XYWGYH9aqxHwVTUPbHaJXxff38e2Y+xBnMltEDyGdn4IVavRmu9YB7dQmol1q
	cQDxTrHPw7+tyMinkQn9xCq1y1wHZ6Bwa+KAYooTsG/Pf7JvTj0aAfmuEjTD9cjxYCRir+srnfc
	8Ka31QLoEBtAAFkR8=
X-Received: by 2002:a05:600c:37c3:b0:490:e19b:bd99 with SMTP id 5b1f17b1804b1-49240e768acmr228789805e9.30.1782124554425;
        Mon, 22 Jun 2026 03:35:54 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49245a69f81sm252844535e9.1.2026.06.22.03.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 03:35:53 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 22 Jun 2026 12:35:52 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/3] bpftool: Add tracing_multi link info output
Message-ID: <ajkQCLW3k0cIEuut@krava>
References: <20260621204524.61067-1-jolsa@kernel.org>
 <20260621204524.61067-4-jolsa@kernel.org>
 <20260621205628.2920D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621205628.2920D1F000E9@smtp.kernel.org>

On Sun, Jun 21, 2026 at 08:56:27PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Repeated parsing of `/proc/kallsyms` in an O(N) loop when symbol loading fails.
> --
> 
> commit 0f11f8e705a95b6aa483a05374ffb9b22bcb78c0
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> bpftool: Add tracing_multi link info output
> 
> This commit adds bpftool support to show tracing_multi link details for both
> plain and JSON outputs.
> 
> > diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> > index bdcd717b0348f..58dadee984a07 100644
> > --- a/tools/bpf/bpftool/link.c
> > +++ b/tools/bpf/bpftool/link.c
> > @@ -377,6 +377,31 @@ static __u64 *u64_to_arr(__u64 val)
> >  	return (__u64 *) u64_to_ptr(val);
> >  }
> >  
> > +static __u32 *u64_to_u32_arr(__u64 val)
> > +{
> > +	return (__u32 *)u64_to_ptr(val);
> > +}
> > +
> > +static struct kernel_sym *find_kernel_sym_by_addr(__u64 addr, bool is_ibt_enabled)
> > +{
> > +	struct kernel_sym *sym;
> > +
> > +	if (!addr)
> > +		return NULL;
> > +
> > +	/* Load it once for all. */
> > +	if (!dd.sym_count)
> > +		kernel_syms_load(&dd);
> > +	if (!dd.sym_count)
> > +		return NULL;
> > +
> > +	sym = kernel_syms_search(&dd, addr);
> > +	if (!sym && is_ibt_enabled && addr >= 4)
> > +		sym = kernel_syms_search(&dd, addr - 4);
> > +
> > +	return sym;
> > +}
> 
> [ ... ]
> 
> > @@ -403,6 +428,43 @@ show_uprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
> >  	jsonw_end_array(json_wtr);
> >  }
> >  
> > +static void
> > +show_tracing_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
> > +{
> > +	bool is_ibt_enabled = is_x86_ibt_enabled();
> > +	__u32 i;
> > +
> > +	show_link_attach_type_json(info->tracing_multi.attach_type, wtr);
> > +	jsonw_uint_field(wtr, "func_cnt", info->tracing_multi.count);
> > +	jsonw_uint_field(wtr, "obj_id", info->tracing_multi.obj_id);
> > +	jsonw_name(wtr, "funcs");
> > +
> > +	jsonw_start_array(wtr);
> > +
> > +	for (i = 0; i < info->tracing_multi.count; i++) {
> > +		__u64 addr = u64_to_arr(info->tracing_multi.addrs)[i];
> > +		struct kernel_sym *sym;
> > +
> > +		sym = find_kernel_sym_by_addr(addr, is_ibt_enabled);
> 
> [Severity: Medium]
> If kernel_syms_load() fails (for example, due to kernel.kptr_restrict or
> a lack of read permissions for /proc/kallsyms), dd.sym_count remains 0.
> 
> Since find_kernel_sym_by_addr() checks !dd.sym_count to decide whether to load
> symbols, won't this cause /proc/kallsyms to be repeatedly opened and parsed on
> every iteration of this loop if the initial load fails?
> 
> This loop occurs here in show_tracing_multi_json() as well as in
> show_tracing_multi_plain(). For tracing_multi links with potentially thousands
> of targets, could this result in a significant performance hang for bpftool?

ok, I think we can make sure the parsing happens just once with
the change below, will do that in next version

jirka


---
diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 58dadee984a0..db780ee39820 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -389,12 +389,6 @@ static struct kernel_sym *find_kernel_sym_by_addr(__u64 addr, bool is_ibt_enable
 	if (!addr)
 		return NULL;
 
-	/* Load it once for all. */
-	if (!dd.sym_count)
-		kernel_syms_load(&dd);
-	if (!dd.sym_count)
-		return NULL;
-
 	sym = kernel_syms_search(&dd, addr);
 	if (!sym && is_ibt_enabled && addr >= 4)
 		sym = kernel_syms_search(&dd, addr - 4);
@@ -431,9 +425,13 @@ show_uprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 static void
 show_tracing_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 {
-	bool is_ibt_enabled = is_x86_ibt_enabled();
+	bool is_ibt_enabled = is_x86_ibt_enabled(), show_symbol;
 	__u32 i;
 
+	if (!dd.sym_count)
+		kernel_syms_load(&dd);
+	show_symbol = !!dd.sym_count;
+
 	show_link_attach_type_json(info->tracing_multi.attach_type, wtr);
 	jsonw_uint_field(wtr, "func_cnt", info->tracing_multi.count);
 	jsonw_uint_field(wtr, "obj_id", info->tracing_multi.obj_id);
@@ -445,7 +443,7 @@ show_tracing_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 		__u64 addr = u64_to_arr(info->tracing_multi.addrs)[i];
 		struct kernel_sym *sym;
 
-		sym = find_kernel_sym_by_addr(addr, is_ibt_enabled);
+		sym = show_symbol ? find_kernel_sym_by_addr(addr, is_ibt_enabled) : NULL;
 
 		jsonw_start_object(wtr);
 		jsonw_uint_field(wtr, "id", u64_to_u32_arr(info->tracing_multi.ids)[i]);
@@ -900,12 +898,16 @@ static void show_uprobe_multi_plain(struct bpf_link_info *info)
 
 static void show_tracing_multi_plain(struct bpf_link_info *info)
 {
-	bool is_ibt_enabled = is_x86_ibt_enabled();
+	bool is_ibt_enabled = is_x86_ibt_enabled(), show_symbol;
 	__u32 i;
 
 	if (!info->tracing_multi.count)
 		return;
 
+	if (!dd.sym_count)
+		kernel_syms_load(&dd);
+	show_symbol = !!dd.sym_count;
+
 	printf("\n\t");
 	show_link_attach_type_plain(info->tracing_multi.attach_type);
 	printf("obj_id %u  ", info->tracing_multi.obj_id);
@@ -917,7 +919,7 @@ static void show_tracing_multi_plain(struct bpf_link_info *info)
 		__u64 addr = u64_to_arr(info->tracing_multi.addrs)[i];
 		struct kernel_sym *sym;
 
-		sym = find_kernel_sym_by_addr(addr, is_ibt_enabled);
+		sym = show_symbol ? find_kernel_sym_by_addr(addr, is_ibt_enabled) : NULL;
 
 		printf("\n\t%-16u %016llx %-16llx",
 		       u64_to_u32_arr(info->tracing_multi.ids)[i],
