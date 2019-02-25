Return-Path: <SRS0=zbR4=RA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B63BC43381
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 20:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408DB2087C
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 20:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy8Gba+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfBYUI3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 15:08:29 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35802 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfBYUI2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Feb 2019 15:08:28 -0500
Received: by mail-qk1-f193.google.com with SMTP id z13so6165324qki.2;
        Mon, 25 Feb 2019 12:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FrFEfcOkoDTOLXmlQymaWSKhtEXBkXOIh8gvGbnPL1Y=;
        b=gy8Gba+jPLnpmnY+9HKlKX8Xol8I5ea10yXrwzTRufi3N4hbLSQqEtxLVGNam5RfKJ
         9GrIl3nAj+FKuioBtjjwNhOTfKpliNchqT9WZiChScCEJcLvkFeIdKJlxAOvybm9WVVJ
         VzDZYb2Cl6Jt1ajF+OPxTnl3Qo4RZlfm45lVLgDaqsWeSGeSTYBY8IdxDddde2wIuXXI
         vXW82Ee34h8/BkSNtft5TtHAFU4eqF3tNAgenHtevzMAwqa55ex5JBa0QhPwjLTYFUi1
         Udl15csuz6GAgoMVwyuMWoTFex+vgZJNVePxbAoykduyQIHJtG16lavvTdiNQf+6uEz3
         0AwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FrFEfcOkoDTOLXmlQymaWSKhtEXBkXOIh8gvGbnPL1Y=;
        b=ADQOrzdVwQZvcaFIuwhR9EDFKf6bHkPNNyQepL9YoGFLUoAuQX3qg9cm9r66ci/No5
         cDUYtOP0+Vh1DBCyx0ahlg0YEAX9GMs9QznsbTw/qOwzTGa/Ubbq9IU4Bme2Hg3aMVsf
         RyAdwgPDKHoYFYlYz1yrengMtGiW3e1MQg3AOpCOa6pwW60RUUjR3toSk4QJwpQt2zKi
         0n6OOFsdHzgnN6eR6bR/g3YgdtTh+JV6ANFe2UD+DE70ALF+DMQNGO3I8VILxdmebful
         wHPGS/uXW+NYvGUEVgCip4lLtqcM7/CUHeGHzoF18qyWDPglg5Vg+483FQx1cExK/jgE
         aAJQ==
X-Gm-Message-State: AHQUAubKBVIN5tvClXgrf9wxFeGNNep4yHI4oW4NmzA+3OQbN4rXjXyn
        MF/67mo9oobfAKg+a7JhCtA=
X-Google-Smtp-Source: AHgI3Ibflpidxc/+qL99tIUN1EyEqeJqovrQEa1tKEaQOSt2mqiOXfjQYdIRgTRD7RqUb3lYvFJSXQ==
X-Received: by 2002:a37:d150:: with SMTP id s77mr14493902qki.334.1551125306907;
        Mon, 25 Feb 2019 12:08:26 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id t38sm8591388qtc.12.2019.02.25.12.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 12:08:25 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A8C6C4039C; Mon, 25 Feb 2019 17:08:22 -0300 (-03)
Date:   Mon, 25 Feb 2019 17:08:22 -0300
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: encoding BTF on glibc was: Re: [PATCH pahole 0/3] fix handling of
 bitfields in btf_loader
Message-ID: <20190225200822.GB13100@kernel.org>
References: <20190220205732.2514975-1-andriin@fb.com>
 <20190222220243.GI26132@kernel.org>
 <CAEf4BzYoJgxYWX9iS7pda62cnGr5VOC70NGgqPurMNWP_w1daA@mail.gmail.com>
 <20190225160239.GR31136@kernel.org>
 <20190225185949.GT31136@kernel.org>
 <CAEf4BzZjnvw9yDKst1xU4PkkcUuPh2Q2Oep=B1jhWSWoO6cgWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZjnvw9yDKst1xU4PkkcUuPh2Q2Oep=B1jhWSWoO6cgWg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Feb 25, 2019 at 11:42:29AM -0800, Andrii Nakryiko escreveu:
> On Mon, Feb 25, 2019 at 11:00 AM Arnaldo Carvalho de Melo> <arnaldo.melo@gmail.com> wrote:

> > Em Mon, Feb 25, 2019 at 01:02:39PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > So yeah, the BTF encoder/decoder is working just fine, the problem is in
> > > pahole's DWARF code, lemme see...
> >
> > Please try the patch below, for me btfdiff continues to show no diff for
> > all types in my vmlinux and now it also produces the same output for
> > when the first element of a bitfield has its bit_size equal to its
> > byte_size * 8:
> 
> Yes, this fixes all the issues I've seen. btfdiff output is now empty
> for my kernel image. Thanks for quick fix!
> 
> Reviewed-by: Andrii Nakryiko <andriin@fb.com>

Thanks, just for some extra testing I tried encoding BTF for glibc 2.28:

[acme@quaco pahole]$ pahole -JV libc-2.28.so.debug
<BIG snip>
[386033] STRUCT dl_scope_free_list kind_flag=0 size=408 vlen=2
	count type_id=385556 bits_offset=0
	list type_id=386034 bits_offset=64
[386034] ARRAY (anon) type_id=385511 index_type_id=13 nr_elems=50
[386035] STRUCT rtld_global kind_flag=0 size=3992 vlen=31
	_dl_ns type_id=386036 bits_offset=0
	_dl_nns type_id=385556 bits_offset=18432
	_dl_load_lock type_id=385917 bits_offset=18496
	_dl_load_write_lock type_id=385917 bits_offset=18816
	_dl_load_adds type_id=385567 bits_offset=19136
	_dl_initfirst type_id=385922 bits_offset=19200
	_dl_cpuclock_offset type_id=385662 bits_offset=19264
	_dl_profile_map type_id=385922 bits_offset=19328
	_dl_num_relocations type_id=385496 bits_offset=19392
	_dl_num_cache_relocations type_id=385496 bits_offset=19456
	_dl_all_dirs type_id=385926 bits_offset=19520
	_dl_rtld_map type_id=385919 bits_offset=19584
	audit_data type_id=386037 bits_offset=28736
	_dl_rtld_lock_recursive type_id=385680 bits_offset=30784
	_dl_rtld_unlock_recursive type_id=385680 bits_offset=30848
	_dl_x86_feature_1 type_id=385571 bits_offset=30912
	_dl_x86_legacy_bitmap type_id=385653 bits_offset=30976
	_dl_make_stack_executable_hook type_id=386039 bits_offset=31104
	_dl_stack_flags type_id=385525 bits_offset=31168
	_dl_tls_dtv_gaps type_id=385825 bits_offset=31200
	_dl_tls_max_dtv_idx type_id=385556 bits_offset=31232
	_dl_tls_dtv_slotinfo_list type_id=386031 bits_offset=31296
	_dl_tls_static_nelem type_id=385556 bits_offset=31360
	_dl_tls_static_size type_id=385556 bits_offset=31424
	_dl_tls_static_used type_id=385556 bits_offset=31488
	_dl_tls_static_align type_id=385556 bits_offset=31552
	_dl_initial_dtv type_id=385511 bits_offset=31616
	_dl_tls_generation type_id=385556 bits_offset=31680
	_dl_init_static_tls type_id=386041 bits_offset=31744
	_dl_wait_lookup_done type_id=385665 bits_offset=31808
	_dl_scope_free_list type_id=386042 bits_offset=31872
[386036] ARRAY (anon) type_id=386028 index_type_id=13 nr_elems=16
[386037] ARRAY (anon) type_id=385938 index_type_id=13 nr_elems=16
[386038] FUNC_PROTO (anon) return=385501 args=(385970 (anon))
[386039] PTR (anon) type_id=386038
[386040] FUNC_PROTO (anon) return=0 args=(385922 (anon))
[386041] PTR (anon) type_id=386040
[386042] PTR (anon) type_id=386033
[386043] STRUCT rtld_global_ro kind_flag=0 size=432 vlen=40
	_dl_debug_mask type_id=385501 bits_offset=0
	_dl_osversion type_id=385495 bits_offset=32
	_dl_platform type_id=385595 bits_offset=64
	_dl_platformlen type_id=385556 bits_offset=128
	_dl_pagesize type_id=385556 bits_offset=192
	_dl_inhibit_cache type_id=385501 bits_offset=256
	_dl_initial_searchlist type_id=385918 bits_offset=320
	_dl_clktck type_id=385501 bits_offset=448
	_dl_verbose type_id=385501 bits_offset=480
	_dl_debug_fd type_id=385501 bits_offset=512
	_dl_lazy type_id=385501 bits_offset=544
	_dl_bind_not type_id=385501 bits_offset=576
	_dl_dynamic_weak type_id=385501 bits_offset=608
	_dl_fpu_control type_id=385977 bits_offset=640
	_dl_correct_cache_id type_id=385501 bits_offset=672
	_dl_hwcap type_id=385520 bits_offset=704
	_dl_auxv type_id=386045 bits_offset=768
	_dl_x86_cpu_features type_id=385599 bits_offset=832
	_dl_x86_hwcap_flags type_id=386047 bits_offset=1664
	_dl_x86_platforms type_id=386049 bits_offset=1880
	_dl_inhibit_rpath type_id=385595 bits_offset=2176
	_dl_origin_path type_id=385595 bits_offset=2240
	_dl_use_load_bias type_id=385529 bits_offset=2304
	_dl_profile type_id=385595 bits_offset=2368
	_dl_profile_output type_id=385595 bits_offset=2432
	_dl_trace_prelink type_id=385595 bits_offset=2496
	_dl_trace_prelink_map type_id=385922 bits_offset=2560
	_dl_init_all_dirs type_id=385926 bits_offset=2624
	_dl_sysinfo_dso type_id=386050 bits_offset=2688
	_dl_sysinfo_map type_id=385922 bits_offset=2752
	_dl_hwcap2 type_id=385520 bits_offset=2816
	_dl_debug_printf type_id=386052 bits_offset=2880
	_dl_mcount type_id=386054 bits_offset=2944
	_dl_lookup_symbol_x type_id=386058 bits_offset=3008
	_dl_open type_id=386060 bits_offset=3072
	_dl_close type_id=385680 bits_offset=3136
	_dl_tls_get_addr_soft type_id=386062 bits_offset=3200
	_dl_discover_osversion type_id=386064 bits_offset=3264
	_dl_audit type_id=386023 bits_offset=3328
	_dl_naudit type_id=385495 bits_offset=3392
[386044] CONST (anon) type_id=386043
[386045] PTR (anon) type_id=385552
[386046] ARRAY (anon) type_id=385515 index_type_id=13 nr_elems=27
[386047] CONST (anon) type_id=386046
[386048] ARRAY (anon) type_id=385515 index_type_id=13 nr_elems=36
[386049] CONST (anon) type_id=386048
[386050] PTR (anon) type_id=385538
[386051] FUNC_PROTO (anon) return=0 args=(385595 (anon), vararg)
[386052] PTR (anon) type_id=386051
[386053] FUNC_PROTO (anon) return=0 args=(385529 (anon), 385529 (anon))
[386054] PTR (anon) type_id=386053
[386055] FUNC_PROTO (anon) return=385978 args=(385595 (anon), 385922 (anon), 386056 (anon), 385950 (anon), 386057 (anon), 385501 (anon), 385501 (anon), 385922 (anon))
[386056] PTR (anon) type_id=385937
[386057] PTR (anon) type_id=385943
[386058] PTR (anon) type_id=386055
[386059] FUNC_PROTO (anon) return=385511 args=(385595 (anon), 385501 (anon), 385640 (anon), 385602 (anon), 385501 (anon), 385954 (anon), 385954 (anon))
[386060] PTR (anon) type_id=386059
[386061] FUNC_PROTO (anon) return=385511 args=(385922 (anon))
[386062] PTR (anon) type_id=386061
[386063] FUNC_PROTO (anon) return=385501 args=(void)
[386064] PTR (anon) type_id=386063
[386065] ARRAY (anon) type_id=386069 index_type_id=13 nr_elems=28
[386066] CONST (anon) type_id=386065
[386067] INT long unsigned int size=8 bit_offset=0 nr_bits=64 encoding=(none)
[386068] INT char size=1 bit_offset=0 nr_bits=8 encoding=(none)
[386069] CONST (anon) type_id=386068
[386070] TYPEDEF ui32 type_id=386072
[386071] CONST (anon) type_id=386070
[386072] INT unsigned int size=4 bit_offset=0 nr_bits=32 encoding=(none)
[386073] ARRAY (anon) type_id=386071 index_type_id=13 nr_elems=1
[386074] CONST (anon) type_id=386073
[386075] INT long unsigned int size=8 bit_offset=0 nr_bits=64 encoding=(none)
Cannot open libc-2.28.so.debug
Failed to encode BTF
[acme@quaco pahole]$
