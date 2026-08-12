Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D5A32D0F5
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786561147; cv=pass; b=mihvoq76Q2ll1zmEZbTG4/ShMxUxL87nkIzq9wfP+/DXWtuv/yB2gcTHRE4XkPyeDY4138KOFwZXrpf3/tApKGQDiMBYoT3dhGxuQGFgb64icdjFxdeXizAq8K6FP20NYC/kI1F0mvf6DVIgQm/bOfem3HbCcbBbgZxu7hbGE9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786561147; c=relaxed/simple;
	bh=Cf62AHvquiW1wPVHoLRVB//an84/OTXj2Xh68mCFV7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QpG2FUoahgdvkBAwmWopTYJ50AqxujRSkruRVIKDPzUNqBuj5h5F2ap4TMOzBMVjbYQJcpK6aXcG9ebCoGPU8JsRNTnr3N454+FMTwf/bUY3oI+O/BmV0+duJrWq9BwnnLTEVQ74cDh+LVnwMByJN+NBax7Ynj4Un1hYzNICAio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXB3OdGZ; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXB3OdGZ"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66804667af2so1390826d50.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 11:59:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786561144; cv=none;
        d=google.com; s=arc-20260327;
        b=kUNv+mP8RBn7YcqlV00tuyvCY2OUS+bxKfx7Kws5FM2HtaA2JvTd8UW0YXPrQ5H+Gt
         4nbkGXxBzfpF+kowPmLLwNeT+XqeeT8RlUAlFh/L2Zr37l380ZfYw3RvvBbEk4e3w5FR
         +MTPzSdPtRA4LP+2+EEVkULyGjlrrlJAR8Fk0vMHMlZESHYbhJxzpJFLJDgRAblMcrdn
         9fTH+/Uc6HkqHdGQh/MWyfwoCij+tIVCZr5VVK8k8Ttarbsn+m+ovHHlsmsd1l67VbYX
         //7J48sYcI9ivIcdWvjoFGg5Cgx8FEueD/Dv0byjQnjd2g5DedVEAyJvUYr2zWStUJae
         sPoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FVIxEE4O6vcmWKuih3FAEgHtBXNG2E3LNfEc3X8cwwA=;
        fh=KFuCT+lsuCBthncmPgCKNp8gBFIheQk8cxGC6Wnibas=;
        b=ATj2nNBZN+V6Ar7P3O9VWN7+8C/qeWWQ8F9hZ3P+zIFs8EHxIsJXtnZo+AKChWxvKp
         5gucibbYInt6dlbyiO3Dtefi2K6khkAptCvDcWlQd9TDX4B+7DVPaAfjQJXmuTe/QNP9
         NXSh1xicla1A9RQhdf3nXteNDIA1QcdJw9KGqncp6cBWRmnPsaffSABs1poNjQXI/2nX
         Shn2uQshY1PK2OfS1xgO8Ls9pYjyv989+7fU8yLRMDlmYHok3k8HcwBYDQJynQnLg3/A
         /RiWK5gAdRWehBvmedT9VCWE96LHXmXyxeGP9BNxYXGQtG9xF0euMxJYHheBtmYGvmlz
         GIMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786561144; x=1787165944; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FVIxEE4O6vcmWKuih3FAEgHtBXNG2E3LNfEc3X8cwwA=;
        b=fXB3OdGZAev40d+COszkXk7CSVP0MhbKh7Br6wqzN3eN9a6201N70MU2R3KAMNeh9Q
         gKq11Gcmy1c7pxyvL/ZgXVpj72P+bI5HPK+4upRa5tOYnSwX0SfejO/yPjKCD3Mg6eUV
         qID50FT9BFochjEr9MAUc+oWamy+hyI431fGw0NoYzivJyrxnVeb1LugjASgYS8iE4dC
         dqW1RZY++FnfC3LZBvLVjuhMLQ9ar7jmdZkDf+fYIFOvEVc1vFCeOIRobHwVl6tReciK
         zs84N/CDdZeXJlL2VO6QbKg3MKdoq63OGueHVzlZdUJILBaIcUMj1TurZj2OcimAf6fj
         6Njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786561144; x=1787165944;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FVIxEE4O6vcmWKuih3FAEgHtBXNG2E3LNfEc3X8cwwA=;
        b=fs2ipSC/FZrVWMS0mjuSWGM8YZACkWqL6rbQjcgPuSA9cJiP5M+4JloHWN/Y8WKZeM
         Q9fzq8YLvEU1gTu40RefYc1ZlwX6AIYFdY9+3bC+86pBhKwqoSRG2uOirAjD8ncnOtGz
         Tr4+A168mFCkubME0ecQHo74hOceyP3MITLL8vFgCEs4pbjD8bRfQj5UwSJg5sM6eUU0
         zduPCbUE3duPJLiE0s7DJ7pvUPbdcyYZJqse0iif2F9DUqt2M4Gq9tY/l8xkm2NAAyXK
         Fmpk7245sgarCt9v1bmRZAobV7rW53wY78YX2uVkyZhcjtph76Ldm7iZ9/pUQrMAKxKC
         qkkw==
X-Gm-Message-State: AOJu0Yz61saXiO10tYxL9y6SADwQUztno7pbk66TfiH6JJkn9xBIKwEW
	wIAXdb0/17fbBe3q7bAHdZXbGH1S6r2vFWee9Q/7cBAQCNexOIgKvJ3x9T1EP12Q2FuxKhCibN/
	SfnU/Rp3BQThBjYBXLGlVckDpx0xn6tY=
X-Gm-Gg: AR+sD13DkNHzPVu7gv652IC4cMcUIwLL8bOUpuo6ZeFdWv0HVKZV+fIJrh2WSdRHTmD
	gI/MHbnkYgAvPcxt4KrBUe8M0Kf86nDd1uFUWMPZOCk7PSw0NnHhKXe1FClr7FO0GZ7Nj0NVMI0
	Evr3U4SLR6PPD/X4btSj+py2FuksddCIXq+ZEPFsiN7dz3cDV75IvpdqdzVsID0DiyrQOc24ys0
	5GkGCnVJjEexWmWrPRAhL3CrpuSt8UzWzC4GDHwIPlrkP8erQkp/1Kls9Bl+KOQLIINeNJioLWI
	NcTjpAL6IQLnERtfh+mDQxXIPzykcUQqEcI6KgSLz/cN
X-Received: by 2002:a05:690e:11c2:b0:667:b72c:8120 with SMTP id
 956f58d0204a3-66c513a08e2mr268067d50.5.1786561144090; Wed, 12 Aug 2026
 11:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706171918.317102-1-ameryhung@gmail.com> <20260706171918.317102-13-ameryhung@gmail.com>
 <DKD3TPJVVM4G.2N5G3FVGL6V73@etsalapatis.com>
In-Reply-To: <DKD3TPJVVM4G.2N5G3FVGL6V73@etsalapatis.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 12 Aug 2026 11:58:52 -0700
X-Gm-Features: AUfX_my-PInsN-P1EfS3zOiGkbRIRYLHBXB_ez0mpmKnPqr-Yr1YA81_1UAsAvA
Message-ID: <CAMB2axPqGPjo-NOVgU+H0q8HhtT3NJr=q_C8d8=_1g7Ed3YmxQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 12/15] bpf: tcp: Support parse/len/write
 header option hooks in bpf_tcp_ops
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	kuniyu@google.com, kerneljasonxing@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 3:19=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> > Add the TCP header option callbacks to the bpf_tcp_ops struct_ops type:
> >
> >   parse_hdr     - parse the options of an incoming skb on an establishe=
d
> >                   connection
> >   hdr_opt_len   - reserve space in the TCP header for bpf options
> >   write_hdr_opt - write the reserved bpf options
> >
> > These mirror the BPF_SOCK_OPS_PARSE_HDR_OPT_CB, _HDR_OPT_LEN_CB and
> > _WRITE_HDR_OPT_CB legacy sockops callbacks, but are exposed as struct_o=
ps
> > members so a program can implement them with normal function signatures
> > and per-member helper sets.
> >
> > The reserved header window is shared between the legacy sockops and
> > bpf_tcp_ops paths. tcp_{syn,synack,established}_options() first run the
> > legacy BPF_SOCK_OPS_HDR_OPT_LEN_CB and then call hdr_opt_len, so both
> > sources accumulate into opts->bpf_opt_len; at write time the legacy
> > options are emitted first and bpf_tcp_ops writes after them.
> >
> > API design
> >
> > bpf_tcp_ops overloads the sock_ops header-option helpers rather than
> > introducing a new API: bpf_reserve_hdr_opt(), bpf_store_hdr_opt() and
> > bpf_load_hdr_opt() are exposed per-member (reserve for hdr_opt_len,
> > store/load for write_hdr_opt, load for parse_hdr) and share the existin=
g
> > kernel option-walking core via _bpf_sock_ops{store,load}hdr_opt(), with
> > the bpf_tcp_ops wrappers synthesizing a temporary bpf_sock_ops_kern fro=
m
> > the program ctx. This keeps a port from the legacy
> > BPF_SOCK_OPS*_HDR_OPT_CB callbacks mechanical (same helper calls) and
> > adds no new UAPI helper/kfunc surface.
> >
> > An alternative considered was to drop the option helpers entirely: have
> > hdr_opt_len reserve space purely through its return value, and introduc=
e
> > a dedicated TCP-header-option dynptr used for both reading and writing.
> > That is a cleaner, more self-contained interface, but it is a larger
> > change and does not reuse the legacy helpers, making a port from sockop=
s
> > less mechanical. It can be pursued as a follow-up; the helper-based
> > interface here keeps this series focused on moving the hooks to
> > struct_ops.
> >
> > The hdr_opt_len fast path in tcp_established_options() is gated by
> > cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS). Note this is a global,
> > per-attach-type static branch: it is enabled whenever any bpf_tcp_ops i=
s
> > attached, even one that does not implement hdr_opt_len or that is attac=
hed
> > to a different cgroup. In those cases the block still runs but
> > bpf_tcp_ops_hdr_opt_len() no-ops via the per-member check in the dispat=
ch
> > macro. A per-member/per-cgroup gate could be added later if the extra
> > fast-path work proves measurable.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> One question I've had both for this and the previous patch: Why are we
> defining new functionality as helpers and not kfuncs? Is it that we can
> allowlist with helpers and not with kfuncs?

These are not new functionality. bpf_reserve_hdr_opt(),
bpf_store_hdr_opt() and bpf_load_hdr_opt() already exist for sock_ops;
the patch only exposes them to bpf_tcp_ops per member and shares the
same option-walking core. I think we have been overloading helpers in
a few places. Adding kfunc equivalents would create a second API for
the same thing and make porting from the legacy
BPF_SOCK_OPS*_HDR_OPT_CB callbacks less mechanical.

Note that allowlisting is not the reason. kfuncs can be filtered per
program too, via btf_kfunc_id_set.filter.
