Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795118769;
	b=QpaLXjNAuEwUedVVSQc8+zgD+tXkeffR7HZvICfPTlI8XhEf/XvL3qMcSz2MXS70LdKj
	 jEUsCgR3QA3DEqxXIboNYHkQsqJ14/v7a/tVzjGRYYUmElYPGowK4unuw8ejOpjLXolN9
	 W73Z4uOELwgmgUyl8fSx9zAxHKn0PhgPHoQ8EddE7zmaHpgXPlPXbPOhSUf6OhlsGhAy5
	 VF0tPcOFM99y6pu1cY1OHEd6n1xtcbFITJdK/EBdguzE02Mu9jIqwu8Qu/yiQj1Whq9Xf
	 wH9up7idrz9nZ6nDJsGHq7B5xoOVLZMGTWmpsvbeS6OET44T4VLwRXllMaWkyHxvhNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795118769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=xZ22FseA32BASXAUihegs+eLkTwU7nxw0EDw4HjdUB4=;
	b=LLwMpy+1P17G8bLsfSgdTDdZjg0CWT9FmPtc3lyGvZBzaF2YXQWo/fo8jB7ZQ+BeL+u4
	 uWytns5/PERJ7Hl/9LqIcr+BOarwNNlWH02O/jjifxYQYsQ2zGNBlU94LHB/vnpyImPph
	 rjuVb4f11dAA9EAgOCOtwTZaqiK9QPkdQIwZFCAWPkOzTY3T/SeQcAokNwvtPMmzUMVcs
	 8TjssMafV07PURkpNZiUWotOG8+GDR7LRn+e576MUalKImCj8nwUVxjg+tMTdXgN+1Be6
	 TJmeCQHttvqjpRA8n0N0HzEvFValggjMeKXBvCARciigSoOqysKkdlzdUtaUHHwLnQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i5FKy7D9;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DD8606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 20:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50DD8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i5FKy7D9
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so793475e9.3
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 12:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795118767; x=1795723567; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xZ22FseA32BASXAUihegs+eLkTwU7nxw0EDw4HjdUB4=;
        b=i5FKy7D964BfjAdJgIebywXm3KuFBLrbOHdcrg67FFdQMxJr6LCXKWohX2mIVC4nUx
         NDokibE7OyCW96aRrOjMVTQ4nEbY8iviGJE0cjNn+De1uokrRlY1EDvzEfdmHGooJL+t
         +Bfi8Le3ffx1KGDa2Uf7d0yiavIQSbctbzI3Je6/uceNyTCFhf2LcB38l4LMuOk2gsa+
         Ih1P1y1LbBwRk4Wm60SYup6yRcULhFzL1av1HmlsOg4CQ5W1loVNOlCZ+16QxCQe3J+D
         MpPHZ3lVWUbK7BjLL5muOEUxihI9eHkwK+tg8x9vuEfoU/yO21op8Fpn+n5AAPS9i/1U
         eDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795118767; x=1795723567;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xZ22FseA32BASXAUihegs+eLkTwU7nxw0EDw4HjdUB4=;
        b=o/sRbfmKDomX+spdnkY7g7/mYoGDu00brBPGc86e1vcNtRXSaOaLPzTxHW1btHhLoM
         50aFdhLLRlmxbOlWulBj6wkJWyLUlx1guha3sioYge01c34d2wzwt1O1s5xkpnHIq3YA
         ESk8fYg2LTka7RBRCS0T0sJvGnfeqynpQ5rMXvCrMmpn7jJub+mytNxsDBVtq2FadbUL
         45hY7TMyWOy71rmR21BqxMSzZIXaKpD6SpVqYn56YtbxqMVn8fljuYzStsUaIbTP6dnb
         1SaXHxF64acCniZ1JngxQKLzcevUh/meSFHQUk2dLWeZykVlPeibD4hXAoI+8SAukVOa
         7CWg==
X-Gm-Message-State: APuU4Z/Z5uQabr3wn5zWtBUplG6UGqLnAjVSPjVGs4us0hFCNa8JXu+h
	qgX96B7/2qpAgVsPpUmNyCXffH2lQvX/wv62bIRocpakUiGRm39/KGckw7zxqz1N
X-Gm-Gg: AYBFou0HKleEmJm/hGoJYc8R2emKd9vgaBpl+fdobbtlcvreEjn+7X1IpWFvrcwqkf1
	X2L12Y5q1qMzOd9q32vh3vL9lKUVNT47GumJFIODaIMl0Z8f8K6zfuk4q7q5ZJJXNTi6A4GDtcV
	BJ2WLm9XC4nvz2rmn4/nTlR9VzGsxMa0/eOYHJ2YLRa+BBk6JUufvt5YGE5RQeg8jOuPFYKdE6t
	7jxkYLLjwA7DymOk8tWykfbKZuF9jIzg3xxDFcgaBdRhTh7zyZ1mFu4mExqwa3RCiAIfRCLzWlZ
	dISKfbsUmNxX818VfwdzugOTBaI9uEeENyrqQSCjiEbMAa51AjgqlrLTuFlD1DHiBZaKEs5zS5o
	oIjQxvpy5DVZNrH8/J8jVOZbg1gR7KN6M1FvrSk37/59J2n8E8CrIYbqyX6E+sQKFUYyPRifXU9
	uJme17XNMQ4qIJAscNAYPdRjHpk1NReYzbIQEtNTsk0CP1hjB04PDN518wBjgArjAsQvejvxlS6
	+Fx4Hj8qrhh13E+xnQJlNgMrfIZtPRnR8wYcwbGxsz/Gm4ogCtmP5pF5JmywGUJFpJ+Gm5nnHZq
	5xbNLruiUJl5O7Rp5GsEmaNB9594LWz0UjoYkK8=
X-Received: by 2002:a05:600d:6510:10b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4bb8881de57mr9548745e9.26.1795118766499;
        Thu, 19 Nov 2026 12:06:06 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm58151335e9.5.2026.11.19.12.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 12:06:06 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 19 Nov 2026 21:06:04 +0100
To: Yingke Xiao <inkxiao12@gmail.com>
Cc: bpf@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
	anna@kernel.org, linux-nfs@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/3] bpf: Fix missing raw_tp_null_args masks for
 NFS and pNFS
Message-ID: <av9WrAhA4skgo5JQ@krava>
References: <CAMcAce9XkYo7gPHMnmRX5EY2dNYO+ECuUF3RkPLnoGHgh8P7tw@mail.gmail.com>
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
In-Reply-To: <CAMcAce9XkYo7gPHMnmRX5EY2dNYO+ECuUF3RkPLnoGHgh8P7tw@mail.gmail.com>

On Thu, Nov 19, 2026 at 02:20:29AM -0500, Yingke Xiao wrote:
> Several NFS client and pNFS layout driver tracepoints pass literal NULL
> or conditionally NULL pointers for struct inode, rpc_task, or struct
> pnfs_layout_hdr:
> 
>   1. nfs4_xdr_badoperation (fs/nfs/nfs4xdr.c:981) passes NULL for arg 2
>      (const struct rpc_task *task) when decoding compound replies outside
>      RPC task context.
>   2. nfs4_set_delegation (fs/nfs/delegation.c:380) passes NULL for arg 1
>      (const struct inode *inode) when stateid refers to an unlinked file.
>   3. pnfs_update_layout (fs/nfs/pnfs.c:1980) passes NULL for arg 4
>      (const struct pnfs_layout_hdr *lo) during first-time allocation.
> 
> Add mask entries to raw_tp_null_args[] so the verifier marks these
> arguments as PTR_MAYBE_NULL instead of assuming non-null pointers.
> Verified on x86_64 7.4.0-rc3 and 6.12.118 LTS.
> 
> Fixes: c83e2d970bae ("bpf: Add tracepoints with null-able arguments")
> Cc: stable@vger.kernel.org # 6.12+
> Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>

besides being mangled patches 2 and 3 do not make sense

  ▎ Patches 2 and 3 are wrong: nfs4_xdr_badoperation, fsnotify_destroy_event
  ▎ and vfs_open are not tracepoints (the closest real one is
  ▎ nfs4_xdr_bad_operation, with no pointer arg 2), nfs4_set_delegation's
  ▎ arg 1 is fmode_t and the inode is never NULL there, and
  ▎ pnfs_update_layout is already listed with 0x10000 for 'lo', while the
  ▎ new 0x1000 marks the iomode enum. The cited source lines don't match
  ▎ the descriptions either. Please drop 2 and 3.

jirka

> ---
> v1 -> v2:
>   - Correct sender identity and Signed-off-by with real legal name per DCO.
>   - Remove drafting notes.
>   - No functional code changes.
> 
>  kernel/bpf/btf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index b234567..c345678 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6607,6 +6607,9 @@ static const struct bpf_raw_tp_null_args
> raw_tp_null_args[] = {
>   { "fsnotify_bump_event_seq", 0x20 },
>   { "nfs4_cb_getattr", 0x200 },
>   { "nfs4_cb_recall", 0x200 },
> + { "nfs4_xdr_badoperation", 0x200 },
> + { "nfs4_set_delegation", 0x20 },
> + { "pnfs_update_layout", 0x1000 },
>   { "nilfs2_transaction_entry", 0x4 },
>   { "iptfs_first_dequeue", 0x1000 },
>   { "iptfs_first_fragmenting", 0x1000 },
> -- 
> 2.43.0
> 
