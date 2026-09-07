Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF990400963
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770055; cv=none; b=ABKHJ1RBVlKpmtZi3wJdoUWd27gZjCNSuu09O9+xl39pKfaFx2v7Vatw+b8HBMF+DPR5oPj6NkSWYec37AwAprhxs386bjbZb6rubQeIAqoJtJhczDGd7jZ7G0bddlB22tt1zoVcVcFu2LBoWBdQZoMTolFJfTatBmcGnrf71j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770055; c=relaxed/simple;
	bh=W2IjegTaQoOtwYTEkrkry58hJKjDrKFkJKOwXvCJtsA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rjc7uYvtTQmim7u/lm1zaY2qUSlU6Pd7JPJ302EHxlYnewAThAazyL56qjvyjpUVBKjSz+TR4/aRTwmOl4qi2TM1PgSPxlrK+B1gvSOpR2xPi4koQcCfl4UNFgGWbFb7F+TFoU3oNOlARsqSfhhl2IYVeJKEH3qOAjDYC6xGyIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGojQ5fS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGojQ5fS"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso30852895e9.0
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 01:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788770052; x=1789374852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3mwxvktzMOsNKcvshDa2AsfaXOZ45qhMtU0CeXC7RLU=;
        b=UGojQ5fSCjLdGUAnGsYVhoXZjphXGVmtYyl3dqaKeznqmevK4yK7bNhJX1iXWnG6VL
         +nk3YKovtTgfSRQf8YL8tsPWpOijeEDYqEp6Nk/2nHSGhsm6fHU7yQ3DPcP1jyKxglRS
         HmMZisBGu09UQ9uXqEr+IIel5S+P3sI6cAin5MEvZQJs9Lxu14myrzXBC6dIKITDGTdU
         hveuNxiFSDPWf6mgBWMhJonARMsHCa67aqxfgkgma8OXrFUkBsYwaqHO+O887uWEnKio
         BAltraTJsRgr3xFtSW1L5Xbp5nTwgnTb5twjz2LXj42tLlIk4NFRdk01CkH9e+a2KoFo
         HABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788770052; x=1789374852;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3mwxvktzMOsNKcvshDa2AsfaXOZ45qhMtU0CeXC7RLU=;
        b=c9DmxTBsW9baBAEzgYMu0fZ3mdqeV6uglQnVoykzE8T4okY4FpsY+WxKDSeqjvb2OJ
         sjOdtzN7e7Z4gRNKroJx+sCdUBcSaokk4w85s5V31jdyaib3uHqoMNf/nah4F05xb6RL
         67YMaQ/uPNMUC9D+vVskjfiHz3jbVhIiuoQt2DjXA31hC4UU0U12dbK3c4fQX4p5346W
         6grSVXMilrvvppdyOPNBpfYJrilezCvw+XNvGDHyiKuJjJkmH1F6dm64wHihLqeGdxjL
         Dh4MSIFTk9Wm4gWl+oWbfcAxb0vO4sCfSyWdhOtfn9mMtND0runVeN8ie1QcRynA+hwq
         iSiA==
X-Gm-Message-State: AFuF++mkhgZOjQV3rDSdpYhBZ2glaVEe0QzshHX0hnwVThNyslqUM1XR
	j7ZvRxz3V5HlLjVQ4eFAJ143cx93tYI5vfg69y1Kv/MQlTrjs3aHo0yj5lUeYDMu
X-Gm-Gg: AYBFou1yQ2dDCGvkM+TkPoyMlDJp7dRVKbFfCeDFNaFxrmp7DTPTVY7a5BkBGALhs34
	WxAtgFqP4ZIM2Qf+oSo1QeqNUfXrPEhsjLov4RaxvBohtf2GakPDriKQZwspxmb9aiKXyG69GJ+
	rx4AKj3fsKwgYUjiNhJk8/DPxoAqwG7+P6VHu67G69KHmem7x2SPSj2PDzb2znRBYiP65hrRdG+
	i/YwKRPnnh6X6pLHH7C43KDyDi+8gKraG5a//mJvqh1s9cDhap43lPQ7U6hlOcs+A5xwnjOihtM
	rterVJnLSIGBB/Zvoa8sMrkTSMcVxK3Jo0wBj+IF6DCgmzNikbJWDaj8oVapusPem5dzWLyaQNt
	fbtb1JmNJQu6tGf0hzxlwvw2c8g/fAdTwY29iCO8oV3chybDS+Me//3u4sUfxMoieNcFWdH3Me+
	amJ/yCDt5lrZCWUaywxf1sjjrSls1xImy+6A==
X-Received: by 2002:a05:600c:314f:b0:49c:ffde:45ff with SMTP id 5b1f17b1804b1-49cffde4629mr156123985e9.17.1788770051991;
        Mon, 07 Sep 2026 01:34:11 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d15918fb3sm9512755e9.0.2026.09.07.01.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 01:34:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 7 Sep 2026 10:34:09 +0200
To: Fuyu Zhao <zhaofuyu@vivo.com>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com, andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com
Subject: Re: [PATCH bpf-next v7 2/2] selftests/bpf: add tests for selective
 module BTF loading
Message-ID: <ap53Ac6p_DVybHi0@krava>
References: <20260907053847.1115-1-zhaofuyu@vivo.com>
 <20260907053847.1115-3-zhaofuyu@vivo.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907053847.1115-3-zhaofuyu@vivo.com>

On Mon, Sep 07, 2026 at 01:38:47PM +0800, Fuyu Zhao wrote:

SNIP

> +static void btf_module_allowlist_default(void)
> +{
> +	struct btf_module_allowlist *skel;
> +	int ret;
> +	LIBBPF_OPTS(bpf_object_open_opts, opts);
> +
> +	skel = btf_module_allowlist__open();
> +	if (!ASSERT_OK_PTR(skel, "btf_module_allowlist__open"))
> +		return;
> +
> +	ret = btf_module_allowlist__load(skel);
> +	ASSERT_OK(ret, "btf_module_allowlist__load");
> +
> +	btf_module_allowlist__destroy(skel);
> +	skel = NULL;
> +
> +	skel = btf_module_allowlist__open_opts(&opts);
> +	if (!ASSERT_OK_PTR(skel, "btf_module_allowlist__open_opts"))
> +		return;
> +
> +	ret = btf_module_allowlist__load(skel);
> +	ASSERT_OK(ret, "btf_module_allowlist__load opts");
> +
> +	btf_module_allowlist__destroy(skel);

^^^ seems redundant, I don't think we need to test that

SNIP

> +void test_btf_module_allowlist(void)
> +{
> +	struct btf *vmlinux_btf = NULL;
> +	struct btf *module_btf = NULL;
> +
> +	if (!env.has_testmod) {
> +		printf("%s:SKIP: bpf_testmod is not available\n", __func__);
> +		test__skip();
> +		return;
> +	}
> +
> +	vmlinux_btf = btf__load_vmlinux_btf();
> +	if (libbpf_get_error(vmlinux_btf)) {
> +		printf("%s:SKIP: vmlinux_btf is not available\n", __func__);
> +		test__skip();
> +		return;
> +	}
> +
> +	/* Ensure bpf_testmod BTF is available. */
> +	module_btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
> +	if (libbpf_get_error(module_btf)) {
> +		printf("%s:SKIP: bpf_testmod's BTF is not available\n", __func__);
> +		btf__free(vmlinux_btf);
> +		test__skip();
> +		return;
> +	}
> +
> +	btf__free(module_btf);
> +	btf__free(vmlinux_btf);
> +
> +	if (test__start_subtest("default"))
> +		btf_module_allowlist_default();
> +
> +	if (test__start_subtest("allowlist"))
> +		btf_module_allowlist_allow();
> +
> +	if (test__start_subtest("skip_unlisted"))
> +		btf_module_allowlist_skip();
> +
> +	if (test__start_subtest("emptylist"))
> +		btf_module_allowlist_empty();
> +
> +	if (test__start_subtest("invalid_input"))
> +		btf_module_allowlist_invalid();

could you add test that verifies the module's BTF did not get
load because of the allow list setup, something like:

  bpf_program__set_attach_target(prog, 0, "bpf_testmod:bpf_fentry_test1")

would fail, or some other way that uses obj->btf_modules

thanks,
jirka
