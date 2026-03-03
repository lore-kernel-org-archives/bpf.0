Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06DD33E34E
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772540904; cv=none; b=JgtmS03dcd00HjDzliozZwq4YyfMutcw4qp/LncVstaIzu1Syvl0aX32QM5+lOL7R/9px8CgmeRet11viqjRwVqqTwE1evDuzqTOM9BIfPd3slUxdRDWI56tYOZBuXIAOCyb54xISBbNzxewuGBWgVyKGI/khmgDUG04+xobNAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772540904; c=relaxed/simple;
	bh=kBBdX6mJ7Qn/upAsEMLjY/CJQO8dS9V1ueDqkwwlumI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=szWn0MXQ5YQSrQH8cTrgP3a3g7A8oAEXL4pMMToW9sQgcNaUYgX4NKL2GyzWjFC5yjfH6qg47yGvif2eUj04DUZFxmQoC3lXncukmvYPumKFJwhW3VjsfF/D3tZ9fau+9jK2lyqhVkV19e2KnKNTAn8LhLGIVV3i3GwFZ0qtQqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JswCGXIA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JswCGXIA"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8fa449e618so803322266b.0
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 04:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772540901; x=1773145701; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VDlk2CxhN/+s7UbyKiiidNIbM6SpyinQ7RPlUl1FFQU=;
        b=JswCGXIAdEx8ydgswZpjnkbbrP39x9YwbGqkfhk7H5m9+ffH9ovHtv2B42X5W1Vmfw
         cB76pbcwNdJOJMrUEFu+UcjqHQx/H+p21theUF4qmZ/RzF9JI2XD5f/yjsrHc4zRiAI1
         U1ErB9ic5G44/O/xmFN4Psy8hCWAvyYT36hQJWW7Dl49lGA1W9SglvQJwDf9ec6KxbMw
         Yx1fSQUHDsv4DF3fWt0uDNJ7eFQZKt8+r3YdTyLlMAVLPRNbv3MeI9tUOEVE5drdfhM5
         ZLDCJZ1mYjG/sls2ZNgPdiXgGaW50PCwakCpUJ4ad+QS2OyvXlprqz3rsBvyHHtdTIN/
         GiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772540901; x=1773145701;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDlk2CxhN/+s7UbyKiiidNIbM6SpyinQ7RPlUl1FFQU=;
        b=iZ25651AJalxmheuhTwfNrE8o6dLOCtBdNdH0wBB1+3kGWRQsu1azgbVmPX5ZKulCY
         7/w7aQAnID6BXCNV6kPr6p12Ru1KTfnWulyGsaIaiPo+mSNwbXcOmpPSlzjOlsRE9fCx
         RS693zq3KcmrFFuopBffiLA7oSjUUteH0kQaiMsGdlNj6vXmfCBCOGlgROuR8CZOVcTK
         xOp32bUuJ1YN0Cj464NzalYB6RxR50K31T9+4yhZr2Ya1nA44nHZ3mYI/PqfuloKuc0d
         acfyCU5KnfcnjuJ5iy9bsRWQtoF6sJ6N1a6tJtOCngWGbiIuOni9Yej4NpqrJYS/LR+8
         aD/w==
X-Forwarded-Encrypted: i=1; AJvYcCUUqLgRARtB0ahREGHMxolKv6ZdPQSX5lorA4x6idOnOSSXu3+r3+wHpcGArJ7SaraZdqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtXLtA1DKzrUeKKuiDqheEDKPX5ar4B8i4XKi81JHA1ZaSbk6C
	ErOkhbAQC2uAw0Ta4bU5kSefQHQxOM4ys01KUjJ6a+ZAJUSMyiRpvrLnz0VaQbfVMrY=
X-Gm-Gg: ATEYQzyFaef244vK3Sto37qqOANseJHKTl9jBKobihPTtO0aJtO+NUkn0vEva+yVvRr
	gw2Tufb07qth0ioiKjRm7OPFVxJQWwKeMT7WQvnFe6Bh7NyjzvYSE2l5B8ct3YizF3SdX62HqGG
	UYyJw8ucbXvsE6cEtj6ZQvTl4/M3wmnK0/Aza+7Fs2l3wfo5Bt5eViKc/y5sMAbDFYq9Jl/sGou
	rhCJh7P1OhEqQtiJ82dan1WT30izl7Dyvg2G7Ob+omsvcA7+PbKzOIA0uMzczMSYvb7DJulqJF9
	penaYQQFxtzpG/r/UKYoKS+enkAlogUEFhbHe7rhIwi0fSCEf2+pX7Iy92ESDy5f5L1lJFfCHWg
	VliMsiFh/byDZczGQh+RSI/zrlXQXhieJu2GvcAPJDw4nR1twndDMEUHy8QDCmKLcn3WVWJVsce
	gyYx9mYhjgQTR5BoX/xkMPYNxCzmM=
X-Received: by 2002:a17:907:9450:b0:b93:6bb6:cb3d with SMTP id a640c23a62f3a-b9376573d38mr1103711666b.58.1772540901273;
        Tue, 03 Mar 2026 04:28:21 -0800 (PST)
Received: from cloudflare.com ([104.28.225.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aec39fdsm581834166b.54.2026.03.03.04.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 04:28:20 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Keita Morisaki <kmta1236@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,  Neal Cardwell
 <ncardwell@google.com>,  "David S . Miller" <davem@davemloft.net>,  David
 Ahern <dsahern@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Kuniyuki Iwashima <kuniyu@google.com>,  Simon
 Horman <horms@kernel.org>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2] tcp: shrink per-packet memset in
 __tcp_transmit_skb()
In-Reply-To: <20260303100439.3172296-1-kmta1236@gmail.com> (Keita Morisaki's
	message of "Tue, 3 Mar 2026 19:04:39 +0900")
References: <20260303100439.3172296-1-kmta1236@gmail.com>
Date: Tue, 03 Mar 2026 13:28:19 +0100
Message-ID: <87bjh5drmk.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 03, 2026 at 07:04 PM +09, Keita Morisaki wrote:
> Use struct_group() to group the three fields in tcp_out_options that are
> read unconditionally by tcp_options_write() and bpf_skops_write_hdr_opt()
> (mss, bpf_opt_len, num_sack_blocks), then replace the full-struct memset
> with a targeted memset of only that group.
>
> struct tcp_out_options is 40 bytes without MPTCP and 96 bytes with
> CONFIG_MPTCP=y (typical distro config). Every remaining field is either
> assigned before first use by tcp_established_options()/tcp_syn_options(),
> or gated behind its OPTION_* flag in tcp_options_write(). This memset
> runs on every transmitted TCP packet, so shrinking it from 96 (or 40)
> bytes to 4 bytes reduces per-packet overhead on the hot path.
>
> Assembly comparison (x86-64, GCC 13, CONFIG_MPTCP=y):
>
>   Before: rep stos zeroing 96 bytes (5 instructions, 12 8-byte stores)
>   After:  movl $0x0 zeroing 4 bytes (1 instruction, 1 store)
>
> Also add opts->options = 0 at the top of tcp_syn_options(), which
> already used |= without a prior clear. tcp_established_options() already
> clears opts->options at its top.
>
> Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
> ---

Loosely related, noticed while reviewing - tcp_out_options.hash_size
looks unused:

 * MD5 - always 16
 * AO - uses tcp_ao_maclen()

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
