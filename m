Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187213502A5
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 04:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782102079; cv=none; b=e4gcHHU6PWEDAuk3KrMyAziIWMVZmu5vsLV+Tz6dv5MOwP3fgknmPnOowbZoB9K+GAmbAYaY9/RR6WR1KouDdDehwVTtYiIhlbSLcGN1BIE8tNyC+WCDmwX57V32yNpUTf7iP8eSPac2C21HZFmBZRQbPWCBtroXwBnXdJQiBRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782102079; c=relaxed/simple;
	bh=rmWC5iPUXUuPyWJTQ8dUYsADCfuCqkBRWLMj90LWriQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABTjT5or1RkNXSVHcAYWizcobfmjcp6OdsVGiu7jWVMEM1NBjEcDadi2n+KfPP1AFQ81yLtMVCRM8d1btnzPs6/EfXnA6K4/amuGlhH//riZjCz6GQT7NnyvtPBvBxox3PeTN81D5zmS89Ob53AltjWsltHLw8aNSXp6x4cK5fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOeqAQT1; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOeqAQT1"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c8857a27041so1618491a12.1
        for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 21:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782102077; x=1782706877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ARbcKkCZMrLR2Q0JBoKtVULOgS6L4oD2K2guHdXuRU=;
        b=EOeqAQT1pPuhqGPmLX5JLWyZ6YQYRdJPzyR22GDCrmpZJrxNjfvLJpt8j4IF+fbqOP
         Mk8YMsf+BxSGiU5knQ8WWztjvOfKc0IueyPbG4iynvqzxhmiMvqd/9VdCmr3OSvNJI19
         ydUQBg2gQBJaCAY5By0E1nrDgUoZwq1J8AK3QHl/5to/Mx2jNNFl+GQBxEKa9yBxZLyk
         MMpEAoBMTvqXlE1kbxkt1u0AVOMt4kQMSzUBNfh6hu2hZJkGMKRT2669rorSMlD3HDUP
         HT4LFVbbe5UE757zOGuiNfLLABzrldPbmF31xe47lId7AAhHHR9lu3Nd17oeZxIlHhWT
         U7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782102077; x=1782706877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ARbcKkCZMrLR2Q0JBoKtVULOgS6L4oD2K2guHdXuRU=;
        b=lb1zzqmgpsnLk+J8e8dnQ39aUxHBfZZy0vfoj+nXhc56Prp07URgVAwhroouJS54Mg
         NK0sgTJByoTdKbg8cIf5Lf3q2ctINkAMuQVzsbZqDN2oD29YeBRARoUf10MyoZBg5SRJ
         n7fUzuZvm3n3X27oF9ulvz58kdP0BiNmCjtSLNJQijfZz8e2/bZO5xhDRsT9tu7s9rst
         r7Q3+QALykX+9w0/uEpPhOOG5uSibMztqKffoH9g47kxXQJJ7dVcIQPCyB502IgaKt40
         nEw8e/e1VIOGQ62hppTwdUAlWRPPEz+fxuPA+WFAxzaq4LY88fR777x6rk0mtKwNLpbR
         s4mw==
X-Forwarded-Encrypted: i=1; AFNElJ8oPKPbva17V/yXx7RhRtqSDDtCZI3hAx3LugmxZdCekToeNlPdN1wTXRhqjY9MWce1J4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa+jPrdjmC6hZW1lr4Lfuyy3t2J/x1ubZpQDoxzgPbCHqdAq5+
	SwIAHFjlVAnK6yF5Gw75qD9op7sDM43ymtMV+wrKNza3cQLyKj63Vbai
X-Gm-Gg: AfdE7clmH/pXsFaAv21utBqjkAjl+qLhKs33JlLaeqpJu+NdZ/4HJtu/7qPiC7Yq/4l
	0FGAa7Xh1x1PFwsk1MCGwprFGhM4KOEvOiuzOU9jLbsyUcRAwdXyNSN9ka4Rj+ti1IP+jerf/Xe
	BbgY1r9NRmxvlJ5qIdn0+e45dqujHDICmdC/VL3Eo7OtnAJJEim3MLY7CvVsGgeM+mqVOX7RKhp
	ODEZzknvdFZfePZvcvYnEi1Sc9QHx7HSTvuuio1w0Hp4U4vU7wem5sel2aYzMK9DCN1PKUyeCmx
	cRXB/bca9x68UAHyUM/BlUhsieu2KQ+F7zC+cA4ObM1Qo8EEGCbdXomqmbykQl7SYVnanGpbATS
	ZxIMHnwt92dmGN3aXx8NYIjq/E9lsHA4EzN8EQJBD1KawMTwBDKhh0uVkV0TYBrdUZYKvGtZ5Kc
	rp5zphYeo9XlyI7Q+gg6vboaFutRTeEz3FRYN4
X-Received: by 2002:a05:6a21:1b81:b0:3b4:b276:3650 with SMTP id adf61e73a8af0-3bb35062637mr14218495637.26.1782102077269;
        Sun, 21 Jun 2026 21:21:17 -0700 (PDT)
Received: from laptop.tail7c0f81.ts.net ([59.6.68.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc2c8f0a7sm5886315a12.7.2026.06.21.21.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 21:21:16 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Preserve scalar zero spills for var-offset stack reads
Date: Mon, 22 Jun 2026 13:21:11 +0900
Message-ID: <20260622042111.955752-1-random6.xyz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <9256454d-6323-4eae-8a0a-e6bcecc92098@linux.dev>
References: <9256454d-6323-4eae-8a0a-e6bcecc92098@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Jun 21, 2026 at 08:29:46AM -0700, Yonghong Song wrote:
> Could you share your C code to desmonstrate patch 1? We can then check
> whether the pattern is common and whether the code can be easliy worked
> around with source code (e.g. barrier_var() etc.).

Sure. I don't have a confirmed production program hitting this, and I
don't want to claim that the pattern is common. The reason I mentioned it
in the cover letter is that it is reachable from normal C codegen, not
only from hand-written verifier asm.

This is the minimized single-slot reproducer I used:

  #include <linux/bpf.h>
  #include <bpf/bpf_helpers.h>

  struct {
          __uint(type, BPF_MAP_TYPE_HASH);
          __uint(max_entries, 1);
          __type(key, __u64);
          __type(value, __u8);
  } single_some_map SEC(".maps");

  struct {
          __uint(type, BPF_MAP_TYPE_HASH);
          __uint(max_entries, 1);
          __type(key, __u32);
          __type(value, __u8);
  } single_one_byte_map SEC(".maps");

  SEC("tc")
  int helper_zero_single(struct __sk_buff *skb)
  {
          __u64 key = 0;
          __u32 out_key = 0;
          __u32 idx = skb->mark;
          __u8 *out;
          __u8 value;

          if (idx > 7)
                  return 0;

          out = bpf_map_lookup_elem(&single_one_byte_map, &out_key);
          if (!out)
                  return 0;

          bpf_map_lookup_elem(&single_some_map, &key);
          value = ((__u8 *)&key)[idx];
          out[value] = value;
          return 0;
  }

  char LICENSE[] SEC("license") = "GPL";

With clang 22.1.6, both -O2 and -O3 produce the relevant pattern:

  *(u64 *)(r10 - 8) = r2
  ...
  call 1
  r7 += r8
  w1 = *(u8 *)(r7 + 0)
  r6 += r1
  *(u8 *)(r6 + 0) = w1

The unpatched verifier rejects the object because the byte loaded from
the spilled-zero key becomes var_off=(0x0; 0xff), so the following
one-byte map-value write is considered possibly out of bounds. With the
patch, the load is kept as const zero and the program is accepted.

I also used a two-slot variant:

  __u64 key[2] = {};
  ...
  if (idx > 15)
          return 0;
  ...
  bpf_map_lookup_elem(&single_some_map, &key[0]);
  value = ((__u8 *)key)[idx];
  out[value] = value;

That produces the same kind of variable-offset byte load over two
spilled scalar-zero slots and shows the same base reject / patched accept
behavior.

I agree that this may be possible to work around at the C source level,
depending on the program, for example by avoiding the variable byte read
from the stack key or by otherwise forcing different codegen. That is why
I kept this as bpf-next and did not claim a production regression.

Thanks,
Woojin
