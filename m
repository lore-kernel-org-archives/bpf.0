Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709622D8370
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 23:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774134623; cv=none; b=f/YjcZGlpaEtL0aAuPTZZRcCRyAaxQFwZ08w4b0Cu5wpM266JP9764U4VGQ4ksQ07SGxP9VdyvwPkNySq4hHVuL+W3n7eHZfur2uz/TqzqyhhzdnAf+2qA4TdHqPGc3mrgWCvt3cyb+QFW4P0F1OVKcVaHGyAGf2XW5AygEuoVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774134623; c=relaxed/simple;
	bh=bD9BWNMuQyvaSmx2fdGXicPgb6I2+/+FR+u7qKP5uUI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmNjWWy5ZvmySrScDucKlhlvItRUFcYD2ahQtscHLVBolmjHD9BktXw6LlgJrbm96A13DeqofeNLT1UuL362VusgvnjOlnZqRX5ubAb5aHq0wYgP90fzcqWKqkedrtQGNU/9IlV454jy5JSBveuTvQwGwVcV2wtWbV0M8/N1l8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ufzy0Mre; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ufzy0Mre"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso15180435e9.3
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 16:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774134621; x=1774739421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=64dkxA+Ldb0rCzo0vk69eVrrTNbPTnROLpZ+Dt8X/gk=;
        b=Ufzy0MreJeQrG4hW6CQqMZDDdvpxb0/XqgiUTs6u8BDyCMqpg7Cxfe94lbAWLeBCHY
         jXHgjKsfQHCdSXTuUxx557LSl4nI4iJysRBueO6vm+LBIEuxXEdsgLFACVR4r41FTw49
         kKPix+GRdAs96MzbFw46fuzDkUHOwjKU/Irh7I8gYroPkGwjGMO3Mrw/e6e+YPvX0EWl
         2XsUYRYL72y5MxbtHERfE5YbFxLyJYUMkLYvtN7CaTEnwB0FSG4Fa/9QAHY5G6S/rxBO
         DFGZhwgmJ07mfZoOxSSZs/gP5bMm0drU1q4TYUrTii1ra9bIjjdSlOm1MGGJ07V0Flw0
         F79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774134621; x=1774739421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64dkxA+Ldb0rCzo0vk69eVrrTNbPTnROLpZ+Dt8X/gk=;
        b=Kl/7tx3VQVLY5GbH2j9seqOx32DsCRRWo1iXv3Zxn2pkaIdFllnyp5q3Ncd0KaoSHi
         Y7Sztv/H0rNwU3uRevRW6lGvkSBWPsUawcyiIy9efJJFfskZSPDXNOjy90PUb30hlfzw
         pwmquh/u+uFljhkRDujPq+sD/G5dWAJ7xlw7B0HXjzPhpwtaa+j8E7AmR/301ywAYWT9
         6ODmVFyelWuQFgMCWxFcLeiaeqe18KMrAABVxF3dus1wtH/fOLTZzO97uz33xAZowGTi
         ovlj9js+PSQy2aK0x3iMEN9IDTi0GpGJLTrlwknpT9bn6D/IfAyxf3a5+Vd7f91aX3Ip
         FQXw==
X-Forwarded-Encrypted: i=1; AJvYcCUC+wNKOGkhhsG5L0g1YGgUT50j5krJFtajNnPizVFquUPy/Mvemvo75SuC+5ekApqdH6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3DF0iEscM2l2hSmISuN60L8be4DGvkbUjEJ+Xd1mVKpUL4LE2
	QWzrgh+DX1/9bDz7hPBm524JPuZwj18qq1dp2NCu+YJLZZEvWfEDU8pc
X-Gm-Gg: ATEYQzwDBJytu+H4RZTs7FpkHrRpxcbZduDHPKkYIESuYACtETSdtE7MJ2QYaKUnMAB
	oSnZztA1kl4UFKkKsbJW+Zz+GQwAmif/yiIBZ8pS2jjKJY+D6Ztmd8gwvgSDpjTtXwqdJVhBrwx
	XQLvYU3sieHY2utsIaKKji0+6Waunv9dLdxsE0zL0+xKRXGSb0EJZg004yF7/PcGrvj3Ggd00/x
	d0xlCs2iiBPSg22vk876wBuNiHU+ylAIOi2TCK80fYFD4MKNeSyxv/W1uKQcH18olBNuSaX6028
	S4Dk/VPpLDgRziOxQD0ZYB4rtLELkP0USWeY3oTJX31ws82iZewqkMXGBaiR2Y4mQHNhl0jnx/i
	W9kcpuZX2PQ56DFYRkzMn0hPwgI/cSBh1XgRNV1Juw3251/E8CFU9AUM3KvS2O9CWnJcwSIg8Dc
	nkC+vbB8gt4ac=
X-Received: by 2002:a05:600c:a43:b0:486:f8e9:add5 with SMTP id 5b1f17b1804b1-486fee0fbcemr96840195e9.19.1774134620577;
        Sat, 21 Mar 2026 16:10:20 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe7dc4a2sm187687955e9.5.2026.03.21.16.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 16:10:20 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 22 Mar 2026 00:10:18 +0100
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH dwarves v3 1/9] dwarf_loader: Reduce parameter checking
 with clang DW_AT_calling_convention attr
Message-ID: <ab8lWhTT8LZGbtQs@krava>
References: <20260320190917.1970524-1-yonghong.song@linux.dev>
 <20260320190922.1970709-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320190922.1970709-1-yonghong.song@linux.dev>

On Fri, Mar 20, 2026 at 12:09:22PM -0700, Yonghong Song wrote:
> Currently every function is checked for its parameters to identify whether
> the signature changed or not. If signature indeed changed, pahole may do
> some adjustment for parameters for true signatures.
> 
> In clang, any function with the following attribute
>       DW_AT_calling_convention        (DW_CC_nocall)
> indicates this function having signature changed.
> pahole can take advantage of this to avoid parameter checking if
> DW_AT_calling_convention is not DW_CC_nocall.
> 
> But more importantly, DW_CC_nocall can identify signature-changed functions
> and parameters can be checked one-after-another to create the true
> signatures. Otherwise, it takes more effort to identify whether a
> function has signature changed or not. For example, for funciton
>   __bpf_kfunc static void bbr_main(struct sock *sk, u32 ack, int flag,
>      const struct rate_sample *rs) { ... }
> and bbr_main() is a callback function in
>   .cong_control   = bbr_main
> in 'struct tcp_congestion_ops tcp_bbr_cong_ops'.
> In the above bbr_main(...), parameter 'ack' and 'flag' are not used.
> The following are some details:
> 
> 0x0a713b8d:     DW_TAG_formal_parameter
>                   DW_AT_location        (indexed (0x28) loclist = 0x0166d452:
>                      [0xffffffff83e77fd9, 0xffffffff83e78016): DW_OP_reg5 RDI
>                      ...
>                   DW_AT_name    ("sk")
>                   DW_AT_type    (0x0a6f5b2b "sock *")
>                   ...
> 
> 0x0a713b98:     DW_TAG_formal_parameter
>                   DW_AT_name    ("ack")
>                   DW_AT_type    (0x0a6f58fd "u32")
>                   ...
> 
> 0x0a713ba2:     DW_TAG_formal_parameter
>                   DW_AT_name    ("flag")
>                   DW_AT_type    (0x0a6f57d1 "int")
>                   ...
> 
> 0x0a713bac:     DW_TAG_formal_parameter
>                   DW_AT_location        (indexed (0x29) loclist = 0x0166d4a8:
>                      [0xffffffff83e77fd9, 0xffffffff83e78016): DW_OP_reg2 RCX
>                      ...
>                   DW_AT_name    ("rs")
>                   DW_AT_type    (0x0a710da5 "const rate_sample *")
>                   DW_AT_decl_line       (1027)
> 
> Some analysis for the above dwarf can conclude that the 'ark' and 'flag'
> may be related to RSI and RDX, considering the last one is RCX. Basically this
> requires all parameters are available to collectively decide whether the
> true signature can be found or not. In such case, DW_CC_nocall can make things
> easier as parameter can be checked one after another.
> 
> For a clang built bpf-next kernel, in non-LTO setup, the number of kernel functions
> is 69103 and the number of signature changed functions is 875, based on
>       DW_AT_calling_convention        (DW_CC_nocall)
> indication.

we don't display these stats, right? would be great and probably easy
to count different flags and aggregate them

> 
> Among 875 signature changed functions, after this patch, 495 functions
> can have proper true signatures, mostly due to simple dead argument
> elimination. The number of remaining functions, which cannot get the
> true signature, is 379. They will be addressed in the subsequent commits.

after this change I have more functions added (below) and I checked
few and they seem ok (w/o DW_CC_nocall)

jirka


acpi_ex_do_debug_object
add_bits
amd_pstate_get_mode_string
dma_alloc_from_contiguous
do_set_pmd
dst_destroy
find_cpio_data
find_microcode_in_initrd
ima_write_policy
insn_init
io_tx_ubuf_complete
ip6_protocol_deliver_rcu
kvm_tdp_mmu_unmap_gfn_range
net_dim_get_def_rx_moderation
net_dim_get_def_tx_moderation
pinctrl_commit_state
string_unescape
syscall_copy_user_array
tdp_mmu_zap_leafs
usb_speed_string
__vlan_find_dev_deep_rcu
__vxlan_fdb_delete
xfs_bmbt_maxrecs
xfs_inobt_maxrecs
ZSTD_buildSequencesStatistics
ZSTD_copyCCtx
ZSTD_findFrameSizeInfo
ZSTD_get1BlockSummary
zstd_get_cparams
ZSTD_getCParams
ZSTD_getCParamsFromCCtxParams
ZSTD_getCParamsFromCDict
ZSTD_getCParams_internal
zstd_get_params
ZSTD_getParams
