Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208FE1DA23
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 00:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770941191; cv=none; b=BI1Q+9hhxpqFWRM4WIh2TtrzB3OgKlpZOKGPoX39itNj99dle/oGAYFLaRGF9eFOGDS3suqhT51F0UAy6RVQ3fLTxLzj0P1QXPC6IzpCdP+9oqs+WmUYnVGDxNtGlSUVy4AJwQ1IwPMNm06GzmtxgT6g+C+RwqJyKq1nSs/1vTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770941191; c=relaxed/simple;
	bh=2sYTMmENz3L3m89h9q3UOV7tFe58KqhuviyE8Ud4h8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3ixiBg8i1Csd8A2568flS42YpTHhQU/E3mPemaoI/foIiL24JSUHSGJ3OaLR1egE2oFhmllPWUA6URONzKTaItLOeyMtPZnoQO8SE8k8XqdrM7Z0t4VjFkgiBeJK7a4Ea4Q8s6ew3PDi9z1wpI1xDq+MK+wS7HvGGWtj/vhrd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JM7VtV8a; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JM7VtV8a"
Message-ID: <82d31503-24d8-45b8-b1dd-2cb35bd28509@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770941186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8kts8v5HAMo16DDajB1UcaSZ1u+c/jPwRAr96cmLOA=;
	b=JM7VtV8aWHAXrhdMCzjxVdqzLMsW/Yj3ZKcnInv6jyubT3Eoh39RVsvZ6X7HLPbg3CZUra
	Cw1xG5IoTFxg36H7gqIyt2hR/4q8Ns9DDl2NtWRQREzGD3urp+MGZh4lPyXg+sF0xqIO0O
	4FbXXOGcQQjM2tZOxqwvjjWArw7mQVE=
Date: Thu, 12 Feb 2026 16:06:22 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 1/1] libbpf: Auto-upgrade uprobes to
 multi-uprobes when supported
Content-Language: en-GB
To: Varun R Mallya <varunrmallya@gmail.com>, andrii@kernel.org,
 alan.maguire@oracle.com
Cc: ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260212152013.17351-1-varunrmallya@gmail.com>
 <20260212152013.17351-2-varunrmallya@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260212152013.17351-2-varunrmallya@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2/12/26 7:20 AM, Varun R Mallya wrote:
> This patch modifies libbpf to automatically "upgrade" standard
> SEC("uprobe") and SEC("uretprobe") programs to use the multi-uprobe
> infrastructure (BPF_TRACE_UPROBE_MULTI) at load time if the kernel
> supports it, making them compatible with BPF tokens.
>
> To maintain backward compatibility and handle rare cases where singular
> uprobes are required, new SEC("uprobe.single") and SEC("uretprobe.single")
> section types are introduced. These force libbpf to use the legacy
> perf_event_open() attachment path.

Maybe you can have bpf programs for both uprobe/uretprobe
and uprobe.multi/uretprobe.multi?

You can add "?" before the section name (e.g., SEC("?uprobe") so you can
selectively enable those programs before loading. This one if one choice
e.g. uprobe/uretprobe is not working, you can then try
uprobe.multi/uretprobe.multi.

>
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> ---
>   tools/lib/bpf/libbpf.c | 42 ++++++++++++++++++++++++++++++++++++------
>   1 file changed, 36 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0c8bf0b5cce4..a32f221d3245 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8265,6 +8265,22 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
>   		prog->type = prog->sec_def->prog_type;
>   		prog->expected_attach_type = prog->sec_def->expected_attach_type;
>   
> +		/* set BPF_TRACE_UPROBE_MULTI if sec_name matches "u[ret]probe"
> +		 * otherwise, leave alone.
> +		 */
> +		if (kernel_supports(obj, FEAT_UPROBE_MULTI_LINK)) {
> +			char *probe_type = NULL;
> +			int n;
> +
> +			n = sscanf(prog->sec_name, "%m[^/]", &probe_type);
> +			if (n >= 1)
> +				if (!strcmp(probe_type, "uprobe") ||
> +				    !strcmp(probe_type, "uretprobe"))
> +					prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
> +
> +			free(probe_type);
> +		}
> +
>   		/* sec_def can have custom callback which should be called
>   		 * after bpf_program is initialized to adjust its properties
>   		 */
> @@ -9822,9 +9838,11 @@ static const struct bpf_sec_def section_defs[] = {
>   	SEC_DEF("kprobe+",		KPROBE,	0, SEC_NONE, attach_kprobe),
>   	SEC_DEF("uprobe+",		KPROBE,	0, SEC_NONE, attach_uprobe),
>   	SEC_DEF("uprobe.s+",		KPROBE,	0, SEC_SLEEPABLE, attach_uprobe),
> +	SEC_DEF("uprobe.single+",	KPROBE,	0, SEC_NONE, attach_uprobe),
>   	SEC_DEF("kretprobe+",		KPROBE, 0, SEC_NONE, attach_kprobe),
>   	SEC_DEF("uretprobe+",		KPROBE, 0, SEC_NONE, attach_uprobe),
>   	SEC_DEF("uretprobe.s+",		KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
> +	SEC_DEF("uretprobe.single+",	KPROBE,	0, SEC_NONE, attach_uprobe),
>   	SEC_DEF("kprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
>   	SEC_DEF("kretprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
>   	SEC_DEF("kprobe.session+",	KPROBE,	BPF_TRACE_KPROBE_SESSION, SEC_NONE, attach_kprobe_session),
> @@ -12722,10 +12740,10 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
>    */
>   static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link)
>   {
> -	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, opts);
>   	char *probe_type = NULL, *binary_path = NULL, *func_name = NULL, *func_off;
>   	int n, c, ret = -EINVAL;
>   	long offset = 0;
> +	bool is_retprobe;
>   
>   	*link = NULL;
>   
> @@ -12752,15 +12770,27 @@ static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf
>   			else
>   				offset = 0;
>   		}
> -		opts.retprobe = strcmp(probe_type, "uretprobe") == 0 ||
> -				strcmp(probe_type, "uretprobe.s") == 0;
> -		if (opts.retprobe && offset != 0) {
> +		is_retprobe = strcmp(probe_type, "uretprobe") == 0 ||
> +			      strcmp(probe_type, "uretprobe.s") == 0;
> +		if (is_retprobe && offset != 0) {
>   			pr_warn("prog '%s': uretprobes do not support offset specification\n",
>   				prog->name);
>   			break;
>   		}
> -		opts.func_name = func_name;
> -		*link = bpf_program__attach_uprobe_opts(prog, -1, binary_path, offset, &opts);
> +		if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI) {
> +			DECLARE_LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
> +
> +			opts.retprobe = is_retprobe;
> +			*link = bpf_program__attach_uprobe_multi(prog, -1, binary_path,
> +								 func_name, &opts);
> +		} else {
> +			DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, opts);
> +
> +			opts.retprobe = is_retprobe;
> +			opts.func_name = func_name;
> +			*link = bpf_program__attach_uprobe_opts(prog, -1, binary_path,
> +								offset, &opts);
> +		}
>   		ret = libbpf_get_error(*link);
>   		break;
>   	default:

