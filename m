Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672958;
	b=qldaV2lYsg1/23WRBbBjW5fuM9fIrvSP0+8U7kDva5mEvkEBl5u6EgINkaqGv0L68Bon
	 yaC4LRf3dGQ3EvXvHxJGUAAC4XKkF3Gg7N3wdg3wF6lxr1lsRA0u5mkE5dF1jYcVIFRoO
	 zFF5srkQL6cBphAAPiFzszMG/IX0KKktg6WjPVYpwMR/vBa+0tC/R07yyxnMaCF/FbTuM
	 ov+mcSONyBjRiCOTjCCoEZiLvec/GXfstc9vIbC58Y86IJi3Rfy2kk3HYTl5CBWseqq2s
	 W5kNIG/XWxtG/2fVwvCLAu6Ao2IMj3ks/++3pJaQ+3+MJA7vXiYjNzOxTREbPuA9dtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=wtbcAf+FvF7jZzxG9NsxCkDjvCktPNS2WNMlwIbxlfE=;
	b=Fur/SXSJdW/hmvv0ppLy7OOUmViyo+qS+kdmEi0ajHNol0ybakumyGYUOPX1saci+VrD
	 W1ou77Skj2fiSS2dkhOV+4f0dD3mYLk0NrcnQb4aD1Cx40Qs/NAMFZo+C1BUicW8rRh7X
	 aHlxmynQf/ZiJIEoSzu5UXQasROUvKogzBSuYcep/0ohRq2Zz1EZjssuyMUxVBvLQr3jU
	 hDwAYOiCyaZsb9OaTN1o0DgEAJiIq9BvE98sLWEqxj3xbGkbMpZwQMamZLS6iKTSOL2ll
	 GeXOjQLVFQnhYZpt6o0WZo1bRaSkAhd1SEWTr10VA2OHzhZh3cgPU80jSI6KDsoyefg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y2I15M6O;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AC3606D81C
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 02:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78AC3606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y2I15M6O
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd6a7e1f4e4so1528575a12.2
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 18:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793672958; x=1794277758; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wtbcAf+FvF7jZzxG9NsxCkDjvCktPNS2WNMlwIbxlfE=;
        b=Y2I15M6OyDBLSoN8WATS31mUd6nyZPFVERxf358zB7YnidBVggy+IXT+DHJw4FG5qk
         rcJIfII6a1/ECPXXCWHmre5PUmdH2+Gn3pp7wRDPaHVB6dd0hkE2Mi2S4tQTxjqWDyqD
         qBkbsMwgfrcZiYhvNWQBtfmo6F2s+ZILjKt1Dzv+xRe3ftQ4DJZ2MlhVHuloHeVLKI+S
         uGUXtYKrItyHbCzA81rAP6QHPk2R8EM4IrO+I5huFcB2dRvEeWM46RZOi7YSwD6w9Bjp
         fgybX27UA5yoWMhQOKSLt3OXck8fwBaEFJehH4E/sANoPtjRxhH7N8KBKPDVJdG78qkx
         7plQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672958; x=1794277758;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wtbcAf+FvF7jZzxG9NsxCkDjvCktPNS2WNMlwIbxlfE=;
        b=RDag+oNv+R3DGKha6mNiEGu/vlqR4+igWiSh2JIyjF7Av4EWtepxNa6VUWb9TSiWdI
         gCJ1bkCI4sVT76XAiBJgGGBpBIqLfK21OSBFo3BPTgAut/naKurbDpx/BIvGiaOpfYJ3
         +hOtsAgkz1pbEGHnJB0tdFAwi2NEPeKevbgk1TzhN1ynh1MExUdWuEvCP164uO8CGwk2
         fqkKoTigt/fohyeqiFXBkmU3f6IwFvqeALnrvi32m+C5NlRFGk7U6+clvl5OwiBdPOof
         f4mwIopU6gS0prH8DSkKHAaVdoymyt36geJaLz5tP8i7FnxpSZg0hQZK9A7ryn5GQB4z
         U7SA==
X-Forwarded-Encrypted: i=1; AKwUvBzBOGeFUajU1mPSRd/3Bjc+NL1AZnaFl4gpejILPjGc6p8aUVJKX0KVcbxWwVvDKY+DhoM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HQbSzb9Ng/G+dHBgsYTPPS0YYKfZUifRejRqmKurfAX9crUzi
	2WVOFEpT/hApxhxRgU0VmjrC+gb/WwG94nQkKZ3jZcP42deR7iBEFLcC
X-Gm-Gg: AYBFou3f1l8wXa7W64vcgp2PvSIxTFupjM6AB2npuaCHaidJAEbRBTprBsx3xBNzzAI
	OF2kBCCgIa5r5EsyxsjukOOoPxRxxDS7WmgZDFUE9/mqdajpqiFO359ufl+kz2ByBhHc05jYvoT
	DHrSCr3WTGTh9eJ9odIzDxgrCGhHbYSAJa6L7FuM6m8qoaHfeakORdCoyzDokWDOIYgkcr9LpQy
	AnnTuyK6xltGEGgoPQBqHMoW5uDV55e7PD0g7/nonPDV1J48qfx+RJAbLXqBpnl0Hdfgl4zJ7FP
	KQ1/0sHpCk3cx/9GHADPMa95G7KBPW5jS7+TIgE3/GN6Wrelg/gUaoaakPQZTh+phaihwbMNOtN
	IfbddVqI2kDrZAksunOI9AO/MKNTCjec2x+AUVoeympkqyI0T93z1RuwzSoOZWsG5PMJ0YEaUg9
	xIItsByENjUgJyOhb7lokoE+jgX1uas0kSLA6qFFkp+zCcnxmSvi04YG9Q9888AXkwsm6A0Y4/s
	MBiR5iCFwqxPm3GX7LHrH53JEkRZwj5TWQIWdTzOBnjBpr7mopIMf1dVb18ysmVBIT23g/+Ez/J
	lRUoFu6BK93a8ZTyoWyJbnMYGZ58SqjZSEig3mswS6QI7DQ/a6pTd5xIUVoXgmlN8d42kN7Xbp0
	L2FO0DVJmXfzfUHHgFNofUmNe0OQRPQbEK+8=
X-Received: by 2002:a17:90b:4c08:b0:3ab:2d17:51c5 with SMTP id 98e67ed59e1d1-3ae8957cfe2mr10200746a91.6.1793672957556;
        Mon, 02 Nov 2026 18:29:17 -0800 (PST)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c72eecasm1705351a91.17.2026.11.02.18.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 18:29:17 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 02:29:16 +0000
Message-Id: <DML7ZWOLYTYS.2BQ9L223JO46Z@gmail.com>
Subject: Re: [PATCH bpf] bpf, lsm: Fix cgroup shim selection for socket
 hooks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Andrea Parri" <parri.andrea@gmail.com>, <kpsingh@kernel.org>,
 <matt@bobrowski.net>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>
Cc: <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <sdf@fomichev.me>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20261102152913.366237-1-parri.andrea@gmail.com>
References: <20261102152913.366237-1-parri.andrea@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 07:29 AM Andrea Parri <parri.andrea@gmail.com> wrote:
> Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
> Cc: stable@vger.kernel.org

Drop it and target bpf-next.

> +	sk = sock ? sock->sk : NULL;
> +	/* NULL from ip_cmsg_recv_security(), no sk yet in sock_create_lite() */
> +	if (unlikely(!sk))
> +		return __cgroup_bpf_run_lsm_current(ctx, insn);

With this hunk one hook uses the cgroup of the socket or the current
cgroup. It depends on the caller.
bpf_lsm_current_hooks is for such hooks. Add the two hooks there.
In __sock_create() the current task allocates the sk. So
socket_post_create gets the same cgroup both ways.
Then there is no need to touch cgroup.c.

Something like this (compile tested only):

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index f58dce8..485e8fe 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -66,6 +66,10 @@ BTF_SET_START(bpf_lsm_current_hooks)
 #ifdef CONFIG_SECURITY_NETWORK
 BTF_ID(func, bpf_lsm_sk_alloc_security)
 BTF_ID(func, bpf_lsm_sk_free_security)
+/* sock->sk is NULL in sock_create_lite() */
+BTF_ID(func, bpf_lsm_socket_post_create)
+/* sock is NULL in ip_cmsg_recv_security() */
+BTF_ID(func, bpf_lsm_socket_getpeersec_dgram)
 #endif
 BTF_SET_END(bpf_lsm_current_hooks)

@@ -95,6 +99,7 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 			     bpf_func_t *bpf_func)
 {
 	const struct btf_param *args __maybe_unused;
+	u32 id __maybe_unused = 0;

 	if (btf_type_vlen(prog->aux->attach_func_proto) < 1 ||
 	    btf_id_set_contains(&bpf_lsm_current_hooks,
@@ -105,10 +110,12 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,

 #ifdef CONFIG_NET
 	args = btf_params(prog->aux->attach_func_proto);
+	/* args[0].type is the id of the pointer. btf_sock_ids[] has structs. */
+	btf_type_resolve_ptr(prog->aux->attach_btf, args[0].type, &id);

-	if (args[0].type == btf_sock_ids[BTF_SOCK_TYPE_SOCKET])
+	if (id == btf_sock_ids[BTF_SOCK_TYPE_SOCKET])
 		*bpf_func = __cgroup_bpf_run_lsm_socket;
-	else if (args[0].type == btf_sock_ids[BTF_SOCK_TYPE_SOCK])
+	else if (id == btf_sock_ids[BTF_SOCK_TYPE_SOCK])
 		*bpf_func = __cgroup_bpf_run_lsm_sock;
 	else
 #endif

pw-bot: cr
