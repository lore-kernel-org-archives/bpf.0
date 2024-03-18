Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2690B381DD
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710765433; cv=none; b=dg0icCBQ3byZPEao3RvOG3A2ykjvaXmf7cY4+SyspfbIVTI/1AEn7ilB1OpNPOsbENnK9gO0wQvB+P4i2SDX2Otq+0hfWXk3v9Ws8RYkgPx/JkluDyRHV1Qr37B2s5vKKXY1MZyrpfLgq2Eyqs43yH72WHRX5VyM2MpNVIP5ruQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710765433; c=relaxed/simple;
	bh=M9ALcJzr0HCGD3fmSiG2S2mtsB1s+S0OgFJOuUsnXR4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfnhS1oQNM2VwxPs+kO2Z/5egevvWtjaJHqGEiE77S+QRTmv9Ww0thPjG1S9zkCbKJFd86DIs8TsLE7dohe4Lc/6sZoxjo8GywWdzTCWlk+oYphVVon0ojAoRr9bfHWV6Dcx/z4Rp3SudXtPQb/RXfzV5ZxF5GVP4l66e3KweJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVe7+Fcm; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVe7+Fcm"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso5703124a12.2
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 05:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710765430; x=1711370230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=auQbLxN2c/29uy5JBIlEIMSQVmIthlFDdWLRTIGxpp4=;
        b=cVe7+Fcms2sdCtAn7zhKhYyNJLJQeoy92R7hjd37YGo7kpsifcPM0WcoiKrxnVKETW
         HwPgljRU9evdIH6TnXDZdXTphGrZJiBBPThDqd+lFgGanc2OQDBEAbGyJRrlMwaYCdgz
         0oOSO4ON81IloI/PxfcUkgGJuIPRMiCgvQg4TzDtZzq6F/CQo53BvCe6/WuU5UKL50Q0
         GkRoYvjePB5mGueMujRqgGxtfDHkwBBc3msNspb1KExSxJqWdwG1I4+fgZRdWUYiBJNj
         aQERXQ8NAwkk/gZ8Nkiqk1wMcLxvuLHGmelVKhU0+NwiXM6eaZPHPkO0Tq/tNnyZ2fCU
         EXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710765430; x=1711370230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auQbLxN2c/29uy5JBIlEIMSQVmIthlFDdWLRTIGxpp4=;
        b=YsVP9I6Hmws9inm25rWaAep0PdB/AGSIlSj9yMd2Nm9hvVeKXEub1YTE7eo+WPuEHS
         lFEUA91E5mCIvihgf9FZ8GYCPP9IOp00CYTKFFf6kSM3EItgrU7+2kIuagTisehEdPTA
         tPNq7hArIWlzweaZjTNwzngbjdtJ3Dw8j3dHuXBwbwkZFM0rqA3iKoOO2hL9hUbjjN4U
         V/X9TC6TJoLMLxkzmeSiNrbzIM0z3ZKRzcU8kh5TMxfrdqBdu4DHRwXk4p6bd22j48nU
         ex7gjso84qKdIeFSVPuOAxP7/lVflX/PD621irZvTLJSGZxWmL8rWABb0eEwFMc4uz23
         FZ/A==
X-Gm-Message-State: AOJu0YxOTKUq2RwncDYLp/ITm1SiUsVV8ZoZrz9se7t0d0vDVIuUNAQA
	2gJypifL1GQD9vkpjckbbxcRjDhuPBqB4S90BhNQq0rW5bR9dAmv
X-Google-Smtp-Source: AGHT+IHzZEZlnjpkGy3TL0YbeXOJNqtvan0FF6aENbSKrPcNI3h9x1afZZLwlAfkz4i0B5alCR8WZw==
X-Received: by 2002:a05:6402:530d:b0:56b:817a:5bcf with SMTP id eo13-20020a056402530d00b0056b817a5bcfmr522008edb.5.1710765430267;
        Mon, 18 Mar 2024 05:37:10 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id g13-20020a056402428d00b005689f3d6936sm4602742edc.53.2024.03.18.05.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 05:37:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 18 Mar 2024 13:37:08 +0100
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yury Namgung <ynamgung@meta.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Allow helper
 bpf_get_[ns_]current_pid_tgid() for all prog types
Message-ID: <Zfg1dO3Wmd_Cj1Jo@krava>
References: <20240315184849.2974556-1-yonghong.song@linux.dev>
 <20240315184854.2975190-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315184854.2975190-1-yonghong.song@linux.dev>

On Fri, Mar 15, 2024 at 11:48:54AM -0700, Yonghong Song wrote:
> Currently bpf_get_current_pid_tgid() is allowed in tracing, cgroup
> and sk_msg progs while bpf_get_ns_current_pid_tgid() is only allowed
> in tracing progs.
> 
> We have an internal use case where for an application running
> in a container (with pid namespace), user wants to get
> the pid associated with the pid namespace in a cgroup bpf
> program. Currently, cgroup bpf progs already allow
> bpf_get_current_pid_tgid(). Let us allow bpf_get_ns_current_pid_tgid()
> as well.
> 
> With auditing the code, bpf_get_current_pid_tgid() is also used
> by sk_msg prog. But there are no side effect to expose these two
> helpers to all prog types since they do not reveal any kernel specific
> data. The detailed discussion is in [1].
> 
> So with this patch, both bpf_get_current_pid_tgid() and bpf_get_ns_current_pid_tgid()
> are put in bpf_base_func_proto(), making them available to all
> program types.
> 
>   [1] https://lore.kernel.org/bpf/20240307232659.1115872-1-yonghong.song@linux.dev/
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/bpf/cgroup.c      | 2 --
>  kernel/bpf/helpers.c     | 4 ++++
>  kernel/trace/bpf_trace.c | 4 ----
>  net/core/filter.c        | 2 --
>  4 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 82243cb6c54d..8ba73042a239 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -2575,8 +2575,6 @@ cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  	switch (func_id) {
>  	case BPF_FUNC_get_current_uid_gid:
>  		return &bpf_get_current_uid_gid_proto;
> -	case BPF_FUNC_get_current_pid_tgid:
> -		return &bpf_get_current_pid_tgid_proto;
>  	case BPF_FUNC_get_current_comm:
>  		return &bpf_get_current_comm_proto;
>  #ifdef CONFIG_CGROUP_NET_CLASSID
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index a89587859571..9234174ccb21 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1730,6 +1730,10 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return &bpf_strtol_proto;
>  	case BPF_FUNC_strtoul:
>  		return &bpf_strtoul_proto;
> +	case BPF_FUNC_get_current_pid_tgid:
> +		return &bpf_get_current_pid_tgid_proto;
> +	case BPF_FUNC_get_ns_current_pid_tgid:
> +		return &bpf_get_ns_current_pid_tgid_proto;
>  	default:
>  		break;
>  	}
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0a5c4efc73c3..1b041911b1d8 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1525,8 +1525,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return &bpf_ktime_get_boot_ns_proto;
>  	case BPF_FUNC_tail_call:
>  		return &bpf_tail_call_proto;
> -	case BPF_FUNC_get_current_pid_tgid:
> -		return &bpf_get_current_pid_tgid_proto;
>  	case BPF_FUNC_get_current_task:
>  		return &bpf_get_current_task_proto;
>  	case BPF_FUNC_get_current_task_btf:
> @@ -1582,8 +1580,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return &bpf_send_signal_thread_proto;
>  	case BPF_FUNC_perf_event_read_value:
>  		return &bpf_perf_event_read_value_proto;
> -	case BPF_FUNC_get_ns_current_pid_tgid:
> -		return &bpf_get_ns_current_pid_tgid_proto;
>  	case BPF_FUNC_ringbuf_output:
>  		return &bpf_ringbuf_output_proto;
>  	case BPF_FUNC_ringbuf_reserve:
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 8adf95765cdd..0c66e4a3fc5b 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -8342,8 +8342,6 @@ sk_msg_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return &bpf_event_output_data_proto;
>  	case BPF_FUNC_get_current_uid_gid:
>  		return &bpf_get_current_uid_gid_proto;
> -	case BPF_FUNC_get_current_pid_tgid:
> -		return &bpf_get_current_pid_tgid_proto;
>  	case BPF_FUNC_sk_storage_get:
>  		return &bpf_sk_storage_get_proto;
>  	case BPF_FUNC_sk_storage_delete:
> -- 
> 2.43.0
> 
> 
