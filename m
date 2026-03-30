Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FCE3290C2
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882424; cv=none; b=ihECTUU68AVt/ahjlG+BSJnfwsB8xgVYDCO3tjr/A19nYjv74yqgmx1tlVL+4Q+VqeY0WO7IOKLgHMKFzJgi5mlYZOOzLUATJ+vEgrxEv7RENMYvkk+jLFI2vFv3IGkcTL+LVrm+stLPKJgD8rgHiJzQyo5Q0+mjiwWGeCorAbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882424; c=relaxed/simple;
	bh=uFKFf9VWROyzVIe6+OengUpbxVbnqSI5Vcr+qWrGods=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFUGnpSQkhkaWaBfXdbWpoZJUZPpxEgEorWs1bw0uZ75yljePIUHXkfCM9aaRsv9VcTOybZCyLU6glkEc1s8f9JnotoBmblddiPfJb+BHmTCy9qAIkhSTQuOxXltNmoBj7yfrvs7mISu0w019TZvoDaBjpbqb4FiRhaGzCH4crA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fh3vU7vt; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh3vU7vt"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43b9d3ebed5so3216531f8f.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 07:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774882420; x=1775487220; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1c6BCRp+6zfBa+LZeKBNzRwbiUzChN7CKkj5VTwZzb4=;
        b=fh3vU7vthyfo7dMZCMqM9aIuMjqVHKQBQQk0z1mQO6w0QIpzb3/DuGmredeBdCK9pi
         XsGTjvnWTbC6YwiZ7LByglFLvhkAweTEd/SXQzcU0aK3p9x4GfuoEb7bz5ArpkeMJKnq
         nNxQsNunQN9D6dcPodjYalEqKU3s+UgKc1GZ+3/2F9aXkXDJD7YOOUiRjFrWSYdsUQ2B
         eft60Rrd2e/LHoScZcOt0PNrcShMfDpTr+0iIrK3D3zqGuugLtVCVHa+BcNKCt8TRs0F
         TIJPgaTTJ9ErBy4lg39pGJSHQymEabAwAdHL9PQf6fgO9qBauQEWR/Is2SwyEzfR5AUN
         79mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774882420; x=1775487220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1c6BCRp+6zfBa+LZeKBNzRwbiUzChN7CKkj5VTwZzb4=;
        b=bj5NSr9H0ln7hq7Ktcna4jRSF1pfsXPaoeBzmq81trYtLJknv33uHoHrWSjqpZq1ol
         fRWPWMbSfibcY29B9430BLlHjI0obczyn8t+xvwVF32Q4JXI/jrKCAPF3eB1pJdKDpA4
         WxktccDntLOnLkBCuRG82fjFIhnOxuUb/x1K1pce4YctW/6G60uLcaosZ341RrQjzKY0
         klHKG1e+/QqQQCp7JMv7q3QMeqlJlYIuOLZkLMmYn0pCy3bcqmN2m0zKyUhYgwHmM61w
         O3XHcjohBPtFuVte9jepgFUTQPcR9otFkDaifH3UiloYjesF2Jybe9KqbVEN5abBsPoZ
         RGLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFGEzk5QBW6XnQX8zkryGaGbhPMvjbHdiuEeEjbAC8NJklTI1kizI1uz+MGPPXntYw5Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqcU1afRWSjppn6qS+HgB3CmjtYqVAUYrqHctmcB7aJ0mnm1fC
	/euP5Shme38G6py7yIZdWTm83QzFpK2lyCGwgTCXxh5Vot3jdTFjQ1bn
X-Gm-Gg: ATEYQzxTwhRR4srwNk6P0JGVmj6Ib3JkhegJXh8rs1dldUgaVKq1xRB3fT7bL9y4vuK
	2gdva60gfoJODNrKgKtxxMJkKj5IZwm7uY12+w9jHYEch3L1UxiFlkOutOzVXIGFh1UBUCSv5Y6
	53x5apflZOxhzZ2pEQNFrqJ5MqkdvFL2eglexbhh4FWyf80aClYhTeAUeYFsiHeMZTpkn10mAAl
	lHCmc9aHyk4ndLuiemTv1cgt3siPkMRbwOPSVy4kZVJkar+THzR/ZzeImsnKPRT2jt2f83v8mYx
	oA8yQKq7nIVBAkG9KfNF+tvNaqwowx4bJYGBTllF7a/ZEgT2dpMY+oERWSry5BVILOqAL+uvFmR
	eldoQTXSPt1kw+tOS8O1g/GjOxU5wPDjrQHeNM7rPikcIww0x89ZjuiQxfqnNCq/MQJYmGX/Ayo
	2s1o5YjjLwtuPDnN9H56MdkChnf/8ZvlNKqlaQVy+tbAjqIIw5ayhFI8+w+w==
X-Received: by 2002:a05:6000:25c7:b0:43c:f95c:3e66 with SMTP id ffacd0b85a97d-43cf95c3ecemr10655210f8f.21.1774882420171;
        Mon, 30 Mar 2026 07:53:40 -0700 (PDT)
Received: from krava (cust-west-par-46-193-1-135.cust.wifirst.net. [46.193.1.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e9e24sm18362075f8f.10.2026.03.30.07.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:53:39 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 30 Mar 2026 16:53:38 +0200
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: andrii@kernel.org, alan.maguire@oracle.com, yonghong.song@linux.dev,
	song@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, memxor@gmail.com, eddyz87@gmail.com,
	martin.lau@linux.dev, menglong8.dong@gmail.com, puranjay@kernel.org,
	bjorn@kernel.org, leon.hwang@linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 3/3] libbpf: Auto-upgrade kprobes to
 multi-kprobes when supported
Message-ID: <acqOcnYHvG4GUgwN@krava>
References: <20260330110019.549079-1-varunrmallya@gmail.com>
 <20260330110019.549079-4-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330110019.549079-4-varunrmallya@gmail.com>

On Mon, Mar 30, 2026 at 04:30:19PM +0530, Varun R Mallya wrote:
> This patch modifies libbpf to automatically upgrade standard
> SEC("kprobe") and SEC("kretprobe") programs to use the multi-kprobe
> infrastructure (BPF_TRACE_KPROBE_MULTI) at load time if the kernel
> supports it, making them compatible with BPF tokens.
> 
> To maintain backward compatibility and handle cases where singular
> kprobes are required, new SEC("kprobe.single") and SEC("kretprobe.single")
> section types are introduced. These force libbpf to use the legacy
> perf_event_open() attachment path.
> 
> The following explain the reasoning for changing selftests:
> - test_fill_link_info.c kprobe→kprobe.single:
>   this test calls bpf_link_get_info_by_fd and asserts
>   BPF_LINK_TYPE_PERF_EVENT and it explicitly needs the perf_event
>   attachment path, which breaks after auto-upgrade to multi.
> 
> - test_attach_probe_manual.c kprobe→kprobe.single,
>   kretprobe→kretprobe.single:
>   this test exercises all four explicit attachment modes
>   (default, legacy, perf, link) and PROBE_ATTACH_MODE_LINK
>   creates a perf_event BPF link which the kernel rejects
>   for a prog loaded with expected_attach_type = BPF_TRACE_KPROBE_MULTI.
> 
> - missed_kprobe.c kprobe->kprobe.single:
>   The link is explicitly checked in the tests due to which it fails if
>   we do not specifically kprobe.single this.
> 
> - get_func_ip_test.c ?kprobe→?kprobe.single: the ? is stripped from
>   sec_name by libbpf at init time so the prog still gets auto-upgraded.
>   It is then manually attached with a non-zero body offset,
>   which kprobe_multi doesn't support.
> 
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c                        | 61 +++++++++++++++++--
>  .../selftests/bpf/progs/get_func_ip_test.c    |  2 +-
>  .../selftests/bpf/progs/missed_kprobe.c       |  4 +-
>  .../bpf/progs/test_attach_probe_manual.c      |  4 +-
>  .../selftests/bpf/progs/test_fill_link_info.c |  2 +-
>  5 files changed, 61 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index bd7b6f486430..9d0a36f8279a 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8265,6 +8265,24 @@ static int bpf_object_prepare_progs(struct bpf_object *obj)
>  			}
>  		}
>  
> +		if (kernel_supports(obj, FEAT_KPROBE_MULTI_LINK)) {
> +			const char *sec_name = prog->sec_name;
> +			/* Here, we filter out for k[ret]probe or "k[ret]probe/"
> +			 * but we leave out anything with an '@'
> +			 * in it as kprobe_multi does not support versioned
> +			 * symbols, so we don't upgrade. Also for '+' as we do not

hum, kprobe versioned symbols?

> +			 * support offsets.
> +			 */
> +			if (((strncmp(sec_name, "kprobe", 6) == 0 &&

str_has_pfx ?

> +			      (sec_name[6] == '/' || sec_name[6] == '\0')) ||
> +			     (strncmp(sec_name, "kretprobe", 9) == 0 &&
> +			      (sec_name[9] == '/' || sec_name[9] == '\0'))) &&
> +			    !strchr(sec_name, '@') &&
> +			    !strchr(sec_name, '+') &&
> +			    !(prog->prog_flags & BPF_F_SLEEPABLE))

is this check necessary?

> +				prog->expected_attach_type = BPF_TRACE_KPROBE_MULTI;
> +		}
> +

maybe add the upgrade logic into separate function, like

   static int upgrade_program(struct bpf_program *prog)


>  		err = bpf_object__sanitize_prog(obj, prog);
>  		if (err)
>  			return err;
> @@ -9924,10 +9942,12 @@ static const struct bpf_sec_def section_defs[] = {
>  	SEC_DEF("sk_reuseport/migrate",	SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE),
>  	SEC_DEF("sk_reuseport",		SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE),
>  	SEC_DEF("kprobe+",		KPROBE,	0, SEC_NONE, attach_kprobe),
> +	SEC_DEF("kprobe.single+",	KPROBE,	0, SEC_NONE, attach_kprobe),
>  	SEC_DEF("uprobe+",		KPROBE,	0, SEC_NONE, attach_uprobe),
>  	SEC_DEF("uprobe.s+",		KPROBE,	0, SEC_SLEEPABLE, attach_uprobe),
>  	SEC_DEF("uprobe.single+",	KPROBE,	0, SEC_NONE, attach_uprobe),
>  	SEC_DEF("kretprobe+",		KPROBE, 0, SEC_NONE, attach_kprobe),
> +	SEC_DEF("kretprobe.single+",	KPROBE, 0, SEC_NONE, attach_kprobe),
>  	SEC_DEF("uretprobe+",		KPROBE, 0, SEC_NONE, attach_uprobe),
>  	SEC_DEF("uretprobe.s+",		KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
>  	SEC_DEF("uretprobe.single+",	KPROBE,	0, SEC_NONE, attach_uprobe),
> @@ -11769,6 +11789,25 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
>  	offset = OPTS_GET(opts, offset, 0);
>  	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
>  
> +	/* This provides backwards compatibility to programs using kprobe, but
> +	 * have been auto-upgraded to multi kprobe.
> +	 */
> +	if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
> +	    offset == 0 && attach_mode == PROBE_ATTACH_MODE_DEFAULT) {
> +		LIBBPF_OPTS(bpf_kprobe_multi_opts, multi_opts);
> +		const char *syms[1] = { func_name };
> +		__u64 bpf_cookie;
> +
> +		multi_opts.retprobe = OPTS_GET(opts, retprobe, false);
> +		multi_opts.syms = syms;

could we do directly:

		multi_opts.syms = &func_name;

jirka

> +		multi_opts.cnt = 1;
> +		bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
> +		if (bpf_cookie)
> +			multi_opts.cookies = &bpf_cookie;
> +
> +		return bpf_program__attach_kprobe_multi_opts(prog, NULL, &multi_opts);
> +	}
> +
>  	legacy = determine_kprobe_perf_type() < 0;
>  	switch (attach_mode) {
>  	case PROBE_ATTACH_MODE_LEGACY:
> @@ -12223,14 +12262,24 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
>  	*link = NULL;
>  

SNIP
