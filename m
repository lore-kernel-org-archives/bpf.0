Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8897C2D879F
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 23:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769558078; cv=pass; b=uoRrNGGoehE3G7ANFyH0KO1uvjknZzNl8Bni59XVRWgYrEJakFfesUmkT/yKvSKUdzMu/vy09ndSgQd2tE9JyBvBZodKUOzFkeka0LfO9gvoScibyOUtKNCgeHz73heZd1dT6wEU4WsHOyaNQDchVg4THG0KWapboxtGV7fPzY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769558078; c=relaxed/simple;
	bh=OrYKPpShGXGBoIlbDfsmIHIsB6wvX3Jk/MeIi73VMrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSRuMagdiDZcUO8r759HdRTLvtGztu60Xt7AIUh8hcJj+r0RR0bg7hcawpO3QVQ1ujt8j+Zk1yTA+Gb0oCLv14gK5gcUPihwT/ufAOWMUdwrHdIXZ8JZUiHcxQUdJMx8lhlNbSkS2Ej3SdXIfsLUWRu6xHwpbMzmGihGOMP+c+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fN8z2p5f; arc=pass smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fN8z2p5f"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4801bc32725so48304355e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 15:54:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769558076; cv=none;
        d=google.com; s=arc-20240605;
        b=SsS6p6Ii9zWmkecrlTX5KxdIUC7Y9rPPV0sfU3nefY0aI0nOQ8d27MywG7ASrpoJ2P
         EDk2mh0PQd8ed82HiJ5FNRbXIJDhrhwKpl6OWodvVENJXqFGFvMBnVJE5XJMnmMJb8cW
         4U8xQx/gsp7XT5Y2NOIavtKGwPq2Jrk4L/m5fkaY2TFySjIpubaFXDRDuQRVo23yWISp
         2lbRbh0oDg/8f5LI960nMwOxwe+OA9+N0FP9LbS0EP31M2fxNPXPKA20GqCzQCsS/smh
         VdMU+6+iLfGpq8U8lPWw0PsGZwRlMxcLR7JEh3wUIZvl86k1aA9phcLbIq3X0XD3+XC+
         wHPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sMeo3s0zo0l7evDIkb9+7ayZwDW0pzxo5+M76gV1+Gg=;
        fh=QFCKBz+bFHUY0exaAOG6K9Mhs13GMv1YfVf4ZOBvWic=;
        b=E68iYUUE+B4Uxv1y8s6yO9IlZG7xgU80LKzyV6fnvp1XhY4q5ViGFG9U+lviJLQg06
         RK/992+iptlPOEoPRKkEquEeqT27D0KX3gtMPOIyiRlASHkrfZtqSb8UVL+hIKGMSf6d
         m8mO7ONU5dFm/RLHsHLo6XEaE/gvd1mVEuxDSrC1VNbpr3lCPnCygNtsplktTY12lqUt
         J6NdsSKsrd6tlaNKwZkhjIt/9bEwoPzZOmlNImdVlcmS1SAcEBtwlzPIP3/oBCuuHuV2
         +G4Jz0b56f/Crxr4ZIqtT3OpZYnBrf3kESXX47obBJkLcuQB0h+khmWBpTYufm4wj5Ay
         0RcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769558076; x=1770162876; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sMeo3s0zo0l7evDIkb9+7ayZwDW0pzxo5+M76gV1+Gg=;
        b=fN8z2p5fpBTr9amTw61E45AFnnMbUGaGlzW7+2eINJix5MBTuDot3ChZuAVLKdGmUs
         JSWv6bN2LBpyZwJ1itXweTgjCxV/3BXcbngC+yNJLDJZjKjwRb0fFTh2vmw61Afnj+pE
         k5oTOWgyMwkuVUD3jEwjU56Wzc75IiEonLxq0VKLqWBcIgnNClfQRDpBRDGspXz/AgiD
         fkZDNGGlQhyUExWoxjStfJro61kdbRqjXqNreJxKxmb8TLuikbzYRcragt/YRA0GHsG6
         gikHJpQrpiQ+IcFSE3/MPuUz16NEI0OcILJeGm8dZa+dilMs4zmasZLLOc/QnM6KymZ3
         wHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769558076; x=1770162876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMeo3s0zo0l7evDIkb9+7ayZwDW0pzxo5+M76gV1+Gg=;
        b=PsTYVU1dYyEIJvajdjqFBBGNMlz6AKLPRzBMHiObeTqWY1WgvJI2nW7F7J/qZ0kXFS
         jJQAPR9IAjujtTHU6wy6uLqnzp1v6/OmrRI7zCtxzOx0TjRuXvTuwspoDKzQtPuQjW5U
         vnymvDzoXPP/kCFrgxiXIjOJmWlrxUYdzFh/vn1lW1cw2t+miHZNIBdRc9I+sXDC22PX
         1i7qVKra6Ikktuf1hE1CUoNhZPDMbXNmlfgP0TyQbmdTNYU/w3IHYdDEylKgwb2yXY/C
         IUtw6ombkM2JylRZmiRYc4HZSHOVjCmPnnVp178/z8ciGkMnnohnXYr80JpnIXy3X59y
         KTpQ==
X-Gm-Message-State: AOJu0YyJk6a7U659F3jZ8KxsT+YeS54qmwEXFaF/YyFXLGG4wwgVJUdi
	LXJ8++3ga1xszrcqcAV2KcXtNRDX38Dwmn8bbgCFvv3/ETb5irf7koy+Wcd29XpY+9G5t8aVs5V
	JeNYWiwC4Eyjw29Y0wKreknzIjMD2uEo=
X-Gm-Gg: AZuq6aJkhXjN0JbmLho7wdACAkLXEcmZ1FCmzwDm/ABPXQNgIZ+sYyAXwh3KhJ7a8XB
	j0jSjxon/GK3zxzbLf3Duvop2ah2PWUUbaNyeJdDbdIiIxT7n/8cc6T0Xb16sJcBg9ej6MTV+kC
	XzbwHEwZ5N2mkLsaAbpmPW9aCoL0XBYdcgJA7qNPKbFI4jF+dKPdq/HY/WH5j+1hjuuea2Iwj80
	WSzf8KF4lKgomHQGnzcYwj/oYUitY4ZX/7iAoizZunWmW3rfj3jLDL/rrvA/Nc8xAjZ6gHyZY7C
	uW+0RMGrgZcIEzOCags3ZsC/bg/s
X-Received: by 2002:a05:600c:3b96:b0:475:dcbb:7903 with SMTP id
 5b1f17b1804b1-48069c37e2dmr48433035e9.9.1769558075894; Tue, 27 Jan 2026
 15:54:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127181610.86376-1-emil@etsalapatis.com> <20260127181610.86376-2-emil@etsalapatis.com>
In-Reply-To: <20260127181610.86376-2-emil@etsalapatis.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 28 Jan 2026 00:53:58 +0100
X-Gm-Features: AZwV_QjgFjV-9UWWtS5yuAgE2_mEHdC1i_HbynSHhHl_68Om0XHWr7k4nPNgh_I
Message-ID: <CAP01T76gi=xQf2jL8gM2nKCULy8HopufkHsy_A00iMwz_7J3mw@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] bpf: Add bpf_stream_print_stack stack dumping kfunc
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, etsal@meta.com, 
	ihor.solodrai@linux.dev, martin.lau@kernel.org, puranjay@kernel.org, 
	song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Jan 2026 at 19:16, Emil Tsalapatis <emil@etsalapatis.com> wrote:
>
> From: Emil Tsalapatis <etsal@meta.com>
>
> Add a new kfunc called bpf_stream_print_stack to be used by programs
> that need to print out their current BPF stack. The kfunc is essentially
> a wrapper around the existing bpf_stream_dump_stack functionality used
> to generate stack traces for error events like may_goto violations and
> BPF-side arena page faults.
>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> ---
>  kernel/bpf/helpers.c        |  1 +
>  kernel/bpf/stream.c         | 13 +++++++++++++
>  tools/lib/bpf/bpf_helpers.h |  2 ++
>  3 files changed, 16 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b54ec0e945aa..c30a9f68af6b 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4562,6 +4562,7 @@ BTF_ID_FLAGS(func, bpf_strncasestr);
>  BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
>  #endif
>  BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_IMPLICIT_ARGS)
> +BTF_ID_FLAGS(func, bpf_stream_print_stack, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_dynptr_from_file)
> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index 24730df55e69..6e2cbe5f34e7 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
> @@ -245,6 +245,19 @@ __bpf_kfunc int bpf_stream_vprintk(int stream_id, const char *fmt__str, const vo
>         return ret;
>  }
>
> +/* Directly trigger a stack dump from the program. */
> +__bpf_kfunc void bpf_stream_print_stack(struct bpf_prog_aux *aux)
> +{
> +       struct bpf_stream_stage ss;
> +       struct bpf_prog *prog;
> +
> +       prog = aux->main_prog_aux->prog;
> +
> +       bpf_stream_stage(ss, prog, BPF_STDERR, ({

I think it would be better not to hardcode the stream, and take an argument.

> +               bpf_stream_dump_stack(ss);
> +       }));
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  /* Added kfunc to common_btf_ids */
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index c145da05a67c..6d8ae3887618 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -343,6 +343,8 @@ extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *a
>  /* Helper macro to print out debug messages */
>  #define bpf_printk(fmt, args...) ___bpf_pick_printk(args)(fmt, ##args)
>
> +extern void bpf_stream_print_stack(void) __weak __ksym;
> +
>  struct bpf_iter_num;
>
>  extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end) __weak __ksym;
> --
> 2.49.0
>
