Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795118752;
	b=1y3uwG4jNF7qV3xbMbdiQ6S62leZH4cIwCSI9u3Q++dVKS4qSH0UuT/mVSeN1wUmgxJK
	 U183SQyCPpP39VcKQEFIZReobcMEro/XagzjixmCXkZofOH/CfKs7A0E4mp0O3sirQJXg
	 tW7hKH6Xc/rdayJxT9Ct+rBsXWKR/kNvQh3okyVQSj938GA/ev5h7e72izagx/U2i5HRj
	 wGWPjw5X9jDY0EgOQZEQV4hn/BABCoYplKlpcuNupLwIHJMOt50i13MMJNZ4pHm59iwI6
	 QdD8ifMQ0ydjB1Hc8+BvtWaN3qJgaYcQfP53hGboV0dNc+dTt2psTPPzW7XwOEXlbKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795118752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=VEkqpd2RoxZ9GRJkgcd4TxF/KKNHXP8mBeFHzci9J80=;
	b=zXr/Gm16m7aTrTBOO7Q/KCm2zmHJLFHrfb7PdEAsenQ0lQmKMV0mgVJP7AwEMKv3cFm+
	 9wawNutDQMl07Wol2kbp0ZfgUHpY/8io05nUrqtu/mJzG4B+iILBkeR/YzbQVcL1NFmI8
	 ejFsmIiVhTO6ateaJywuC4V1mO50xcFBu/J/5O/3puYx5+ECqj6loIGIlT6dWF53E/uWr
	 QvxqpEjljVNmdQioKXpPPbaGgY3hYBtZ3THacq2Z0t2f1pbTqZJAaW+bE+i1OsNpfu8xA
	 Ou4pFHk8xiuYOdOsUtO1bHVzX3jO38gntCMZU6U2g0VjkkweMRP1+Rvcz8bxKRftUbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U8kap+ui;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91257606A32A
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 20:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91257606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U8kap+ui
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so939955e9.2
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 12:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795118750; x=1795723550; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VEkqpd2RoxZ9GRJkgcd4TxF/KKNHXP8mBeFHzci9J80=;
        b=U8kap+uiMZ33ZZ7fx3ualzidBqymKwK1L+aYTWKFPrQdqccOtZLLGbr5/LBFP6Ry83
         7Y93SNsln6Fbf+K8GJHPn8iYNAK8PAbHPbrZkhp3bbpPul7MXXJNjDuEVyL0s7Xdm9KB
         ugPt9d6PP/fSws8kfJLYG3bZtDhSD+aFVZ7t6e4C1XvkRKD962qnZeQEJo36cqsBkZBx
         QaWqBC5VHKG/iDQWqlOgIXeb+4SsDudqOTBkYTqqJV9IkCf02pnu+xW1b1Mte4OO1qfQ
         +OzXdUMRH31yEHgOBDXoiu/H57ArVbXCbnNv58mZE9PQKYtD8lS/VBC0aNTSWRCn8pUl
         pGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795118750; x=1795723550;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VEkqpd2RoxZ9GRJkgcd4TxF/KKNHXP8mBeFHzci9J80=;
        b=PcCnvwSEnf1W4dTg8EEO4kiWgEV7xcWIhunpDFUATXM+Lq09p2mbACmrWMXjrrHr68
         PnVn7N663LqITjLiMxE4AvTl/y5r8Ej/wu9AHD4O3akAW4Oj8tJmZ+HXXZ7pH1TxxjqX
         tI4nCtZ6PA9sxiEMUoMKkFkegcNIZs1M3dMqeH2czWGDJxlgSz7H6CRodoYqqf3ApEzY
         VoIFHjzws88hFA5OuAZ4H7+Dx9ORO4Ml47/kAXER8/uQD+GBAKeG/OdLItkp5pNkdY84
         E0jDTJz0crIqhVYT56ggL/7jVjsNxWMOz7iZUkihTmusuXFJ9Erp1+1OwNHc5M1NNzhx
         xrDA==
X-Gm-Message-State: APuU4Z8S9Xf3bvr9xIzlhtTPQlyJTWC9ZPylxaORhaLQsHz+itMdZqaa
	5uhXSd0uxcPJc8iZsAbCAdMhIfV6zpg7hdZ2lyz4EIF8ahfo3oOiQJZa
X-Gm-Gg: AYBFou0N9CyfdiWXufSXHPuWFP7gFSaZU/FxnDBEHhKoG+TZgncfhnEVbrLlMmyG0Dy
	nItC2uIhyhBWJXAh8rtHIm+XuVcTA0MGowtH5Z/4DuiFRnwLBtGggFzQQ4CfQAilFXwcwL0PHi/
	9TxWWGDPeKeESsn1nkoXW5nDkD1x+YAcdfwkxfQfG3v9Ex0bj+hWqditF8G7nlywK7TE8CGhDAO
	8d95b9jeshAWfvUgy/ETGKEJfbC1ce5Wz59D+vs93Z4Fi4Sb6mlRZf7NJHMyroaoBdEYnNdAqrT
	wTuFQoiGIX0PJvKgu7EONN7DHWAiOK1X0X1h7yYrIqjrF1jc1rvA7eA73imw8uTP61r4s5ENSUx
	rRD+rqzKPN66e36tPQmJ5pc7/7aqsIJ1neBYJoh7VjkIk6cDKdlKfddHCdaUtoCIVSkjGc2tMDi
	YN0dYCU7p49aTO+rvmrzvm6yuznfV+fqH7tq9r/aYj9RIE4LLLOTARW44q4u9PeVGXPzFLH0PMJ
	nwXH5XTwZelq5EnMJMrACJqLjMBCvu9IO/4kDy5X9ONN3Wlf5Ib4uhobNbJP9lw4wCaSlHz6NXN
	VQhAe7FSw8r1GSQw
X-Received: by 2002:a05:600c:3f0a:b0:4a5:75d2:c104 with SMTP id 5b1f17b1804b1-4bb8880cde7mr12400535e9.22.1795118749858;
        Thu, 19 Nov 2026 12:05:49 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm20190405e9.8.2026.11.19.12.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 12:05:49 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 19 Nov 2026 21:05:47 +0100
To: Yingke Xiao <inkxiao12@gmail.com>
Cc: bpf@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
	anna@kernel.org, linux-nfs@vger.kernel.org,
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/3] bpf: Replace DECLARE_EVENT_CLASS names in
 raw_tp_null_args[]
Message-ID: <av9Wm6HQ-DIgFhfw@krava>
References: <CAMcAce-ytH2Xt_0+1fKXzxy+a8fi0Md-4SSoLZ1RQxKQoLq-tw@mail.gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMcAce-ytH2Xt_0+1fKXzxy+a8fi0Md-4SSoLZ1RQxKQoLq-tw@mail.gmail.com>

On Thu, Nov 19, 2026 at 02:18:29AM -0500, Yingke Xiao wrote:
> btf_ctx_access() strips the "btf_trace_" prefix from attach_btf_id
> and matches tname with strcmp(tname, raw_tp_null_args[i].func). Because
> each attachable tracepoint typedef corresponds to a DEFINE_EVENT() name
> rather than its DECLARE_EVENT_CLASS() template, three existing entries
> in raw_tp_null_args[] never match any program:
> 
>   1. "nfs4_inode_callback_event" and "nfs4_inode_stateid_callback_event"
>      are DECLARE_EVENT_CLASS templates in fs/nfs/nfs4trace.h whose
>      DEFINE_EVENT instances are nfs4_cb_getattr (:1455) and
>      nfs4_cb_recall (:1518). fs/nfs/callback_proc.c:50,106 pass literal
>      NULL for arg 2 (const struct inode *inode), and TP_fast_assign
>      (:1424, :1481) checks !IS_ERR_OR_NULL(inode). Keeping 0x200
>      (0x2ULL << (2 * 4)) sets ptr_err_raw_tp = true so btf_ctx_access()
>      assigns SCALAR_VALUE to ctx[2], rejecting any pointer dereference
>      even under if (inode) and matching existing raw_tp_null_args[]
>      0x2-nibble convention (0x300 yields the identical SCALAR_VALUE).
> 
>   2. "iptfs_ingress_postq_event" is the DECLARE_EVENT_CLASS template in
>      net/xfrm/trace_iptfs.h:108 whose DEFINE_EVENT instances (:130-148)
>      are iptfs_first_dequeue, iptfs_first_fragmenting,
>      iptfs_first_final_fragment, and iptfs_first_toobig.
>      net/xfrm/xfrm_iptfs.c:2025 and :2051 pass literal NULL for arg 3
>      (struct iphdr *iph), requiring mask 0x1000 (PTR_MAYBE_NULL).
> 
> Replace these dead template names with their DEFINE_EVENT tracepoints.
> Verified in QEMU on x86_64 7.4.0-rc3 (iptfs_first_{fragmenting,
> final_fragment} and nfs4_cb_{getattr,recall} flip from LOADED to
> REJECTED) and 6.12.118 (nfs4_cb_{getattr,recall} flip from LOADED to
> REJECTED; iptfs_first_* absent in 6.12).
> 
> Fixes: c83e2d970bae ("bpf: Add tracepoints with null-able arguments")
> Cc: stable@vger.kernel.org # 6.12+ (nfs4_cb_*)
> Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
> ---
> v1 -> v2:
>   - Correct sender identity and Signed-off-by with real legal name per DCO.
>   - Remove drafting notes.
>   - No functional code changes.
> 
>  kernel/bpf/btf.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 

patch is mangled/broken, can't apply it (check Documentation/process/email-clients.rst)

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a123456..b234567 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6605,10 +6605,13 @@ static const struct bpf_raw_tp_null_args
> raw_tp_null_args[] = {
>   { "bcache_journal_entry_close", 0x20 },
>   { "bch2_journal_entry_close", 0x20 },
>   { "fsnotify_bump_event_seq", 0x20 },
> - { "nfs4_inode_callback_event", 0x200 },
> - { "nfs4_inode_stateid_callback_event", 0x200 },
> + { "nfs4_cb_getattr", 0x200 },
> + { "nfs4_cb_recall", 0x200 },

seems correct

>   { "nilfs2_transaction_entry", 0x4 },
> - { "iptfs_ingress_postq_event", 0x1000 },
> + { "iptfs_first_dequeue", 0x1000 },
> + { "iptfs_first_fragmenting", 0x1000 },
> + { "iptfs_first_final_fragment", 0x1000 },
> + { "iptfs_first_toobig", 0x1000 },

llm says:

  ▎ Only iptfs_first_fragmenting and iptfs_first_final_fragment pass NULL
  ▎ for iph (net/xfrm/xfrm_iptfs.c:2024, :2050). iptfs_first_dequeue and
  ▎ iptfs_first_toobig always pass ip_hdr(skb). Since the old class entry
  ▎ never matched, adding those two would start rejecting existing
  ▎ programs that use iph without a NULL check, even though it can't be
  ▎ NULL there. Should we add only the two NULL-passing events?

jirka

>  };
> 
>  static bool is_raw_tp_null_arg(const struct bpf_raw_tp_null_args *entry,
> -- 
> 2.43.0
> 
