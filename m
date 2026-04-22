Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226612770A
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 01:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776820600; cv=none; b=BakQDa3YTM7VOU+PxLxU5sumUJFBaZbbeZzO8KhorlVS4Z1z/rHYxPkDKCvXyYRXYE77nP3hsPeHiI0c0naTIBzoi/aLnTZegw3nDhy4Wv5eP2gpoknrTVtslELtPSLVUfX03ArQ4lzwKdS1mzsxjhYGn98StDdRiftaLUApVVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776820600; c=relaxed/simple;
	bh=+glTvh+3pd61TNuS/coSF0x3fHvrwq0K5MnpCRrrhbM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=CNUCD+LJpRY8mCufdlnv/dvhrAQu3HmY+xpzfyzXMBM95pY988HYMxFtll2S3Ej7+2Ll2WBlBIaTfrL/7Bd91lP+EuIi5W17AEaJmOBKO/Vs/2fuSg4PPxIEy5UOiZEjsJ4vtOgK+n8a247vr9L/X4DEC+wW44i/H78gy+ot7U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWYjEgr0; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWYjEgr0"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-42321c8b8f5so4055703fac.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 18:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776820598; x=1777425398; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZbXJz5FOySzln15odWfqD0QlOJf0U+stx+/71ykXNk=;
        b=HWYjEgr0wnaX2wK+rGE8RZ7eZmh6iDGgxot5XhiMb13uS4d/B43XMs5Vu5AUh1dvOw
         8vCM/+Ajqwad9cdabFeDaCLSSAd7sA01vC/syrxdWBnhG2E3bSEB5xrfIAD2hXJmHDkc
         YzY1p+A7jA+P0mHf+sEVh6CUw1G2QQBi7SUc+qRxHiYont78bWMI1pJa2eg563I1GXKE
         zEXNTYRyc2N2nmsX7bc3k+4dLutmiGmSMqf2sNW2pPmPROm8nIzxhOdFzcUuZGGFC0qX
         j9PyaMkhANs7MJ+JCqT6+VYETweYHYTfEaOnCpxu0GSdZq5oTJN4CMUQ2tAnxEYFPHS2
         qJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776820598; x=1777425398;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZbXJz5FOySzln15odWfqD0QlOJf0U+stx+/71ykXNk=;
        b=S434K5T7UXmEqYs73Swdi4hzq/oRVmryeCiRia7ZzSmeKgZoKnnS4zNrl3Sg3wo5cK
         4RXm4RvxfQiuBIH8IAb/guK2arvElzfnthinnnTHJKjPmMrcIrRGzNzjU/FVKCDEu/oo
         1nf5jSZOL2f6phNODUbzPEUzAcD10KxiCjboOQqz4C2Eu09l+OCxrubUs1yYOtTRqlzt
         LWysLjXpeCyc5id4BdIb8U1h8CgFCG/ZYedbVnjLOjyrlpEaS6x/ONe/WTS4aRxre0Ln
         rv4nllVpu8FpfTPmSk/FCmJKMimXpMZkI6NN/6k9h7qOBlDYrnzHqUyNrhJGCKKFMgkE
         ISpg==
X-Forwarded-Encrypted: i=1; AFNElJ/psVK5l8Y3LfHWM0FSACbDcJl5H95bAUW5hT3xzTgaUTkQMnT6F0E3fTu6puOJio9aRNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdjKsiuQ+yDIkadpuwEXVwtNwWVraJDvU2HZS/hpuw1fROavNC
	oWh0dwn+3dmyEE1H7DGEQJ11K0X4eP4+z4K3Q/HgZgde7k1hFgLoPYBm
X-Gm-Gg: AeBDievZ4JsEmvIYnMRp4/29IqpzPKj8elgwJwZxH6/P9+4CCKzOYOR1QsE9eAPZwAh
	I98j6FShsQLahQxPxhy9HNCT75L3wd2v55+/0qzAqlSUyNYSYxJWq0vLXWtvOSioMniIlzucnbd
	V8+iq2keS0SHAnx/w17RQ+z57XCLn38cATDuZAdXmWEqQwMun5znMP7VBhPPB6zk87p3PVqY19m
	oEN9b9UQ41BRpuGRE+6g/nF3k07cpWIdGo5MMvr4MO3Og3HfX4t1w7+lEUmb5SCEr47GwwJYuya
	+l3ZbuYw3PO61baCk2B+qdaXt6v5GJx2t36XdQ8PLIbS5NhW9vV/Efvsv5Q7FwGlB462KU+Ibnr
	lic+stOrzar4TlhBjF1U/AmT9hRaNOpmIfMeJ7+gsP+Htokz3kkMTrhA/fbkjKk8xpFUsvamdVz
	74iyInrblEWG9Mv0+vIppQuT4AI4Rqz4yyJZSZXK0rV+ZrVhgGTrbztrL8mO7eYSkl0KqrqwLXl
	W641zvsg+3mFcg+pGvx1MwHeM2g
X-Received: by 2002:a05:6871:c8cd:b0:423:4e3f:7570 with SMTP id 586e51a60fabf-42a99aca461mr10759003fac.15.1776820597957;
        Tue, 21 Apr 2026 18:16:37 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:56::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b9304b7f6sm13650044fac.1.2026.04.21.18.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 18:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 18:16:36 -0700
Message-Id: <DHZAC1DIKBSJ.2CO1A8NY2B2EM@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
Cc: "Puranjay Mohan" <puranjay12@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, "Fei
 Chen" <feichen@meta.com>, "Taruna Agrawal" <taragrawal@meta.com>, "Nikhil
 Dixit Limaye" <ndixit@meta.com>, "Nikita V. Shirokov"
 <tehnerd@tehnerd.com>, <kernel-team@meta.com>
Subject: Re: [RFC PATCH bpf-next 0/6] selftests/bpf: Add XDP load-balancer
 benchmark
X-Mailer: aerc
References: <20260420111726.2118636-1-puranjay@kernel.org>
In-Reply-To: <20260420111726.2118636-1-puranjay@kernel.org>

On Mon Apr 20, 2026 at 4:17 AM PDT, Puranjay Mohan wrote:
> Sample single-scenario output:
>
>   $ sudo ./bench -a -w3 -p1 xdp-lb --scenario tcp-v4-lru-miss
>   Calibration: 84 ns/op, batch_iters=3D119047 (~9ms/batch)

why print this?

>   Proportionality check: 2N/N ratio=3D1.9996 (ok)

why print this?

>   Validating scenario 'tcp-v4-lru-miss' (batch_iters=3D119047):

why print batch_iters ?

>     [tcp-v4-lru-miss] PASS  (XDP_TX) IPv4 TCP, LRU miss (16M flow space),=
 CH lookup
>     Flow diversity: 16777216 unique src addrs (mask 0xffffff)

why print this?

>     Cold LRU: enabled (per-batch generation)
>
>   Scenario: tcp-v4-lru-miss - IPv4 TCP, LRU miss (16M flow space), CH loo=
kup
>   Batch size: 119047 iterations/invocation (+1 for validation)

and then print them again to hammer the point ?!

>   In-BPF timing: 203 samples, 119047 ops/batch

and 3rd time to really annoy humans.

>     median 856.8 ns/op, stddev 39.4, CV 4.54% [min 817.4, max 1173.6]
>     p50 856.8, p75 881.4, p90 918.3, p95 943.3, p99 976.3
>     NOTE: right-skewed distribution (tail 3.6x the body)

Too much data. What humans suppose to do with all of that?

>
>     Distribution (ns/op):
>          <p1 : 1         (below range)
>          820 : 4         |***                                     |
>          830 : 31        |*****************************           |
>          840 : 42        |****************************************|
>          850 : 33        |*******************************         |
>          860 : 25        |***********************                 |
>          870 : 15        |**************                          |
>          880 : 8         |*******                                 |
>          890 : 14        |*************                           |
>          900 : 6         |*****                                   |
>          910 : 6         |*****                                   |
>          920 : 2         |*                                       |
>          930 : 5         |****                                    |
>          940 : 2         |*                                       |
>          950 : 3         |**                                      |
>          960 : 2         |*                                       |
>          970 : 2         |*                                       |
>         >p99 : 2         (above range)

I frankly don't see a point.
It proves that bell curve exists. So? I would remove it completely.

>
> Sample run script output:
>
>   $ ./benchs/run_bench_xdp_lb.sh
>
>   +----------------------------------+------+----------+---------+-------=
-+----------+----------+----------+----------+
>   | Single-flow baseline             |    n |      p50 |  stddev |     CV=
 |      min |      p90 |      p99 |      max |
>   +----------------------------------+------+----------+---------+-------=
-+----------+----------+----------+----------+
>   | tcp-v4-lru-hit                   |  202 |    83.14 |    0.16 |  0.19%=
 |    82.79 |    83.31 |    83.51 |    83.60 |
>   | tcp-v4-ch                        |  201 |    92.26 |    0.12 |  0.13%=
 |    92.05 |    92.41 |    92.57 |    92.68 |
>   | tcp-v6-lru-hit                   |  202 |    81.00 |    0.12 |  0.14%=
 |    80.80 |    81.15 |    81.45 |    81.56 |
>   | tcp-v6-ch                        |  201 |   106.36 |    0.14 |  0.13%=
 |   106.07 |   106.55 |   106.73 |   107.03 |
>   | udp-v4-lru-hit                   |  202 |   114.65 |    0.17 |  0.15%=
 |   114.22 |   114.85 |   115.02 |   115.06 |
>   | udp-v6-lru-hit                   |  297 |   112.91 |    0.17 |  0.15%=
 |   112.56 |   113.13 |   113.45 |   113.50 |
>   | tcp-v4v6-lru-hit                 |  298 |    81.28 |    1.11 |  1.37%=
 |    80.09 |    82.04 |    86.32 |    86.71 |
>   +----------------------------------+------+----------+---------+-------=
-+----------+----------+----------+----------+
>   | Diverse flows (4K src addrs)     |    n |      p50 |  stddev |     CV=
 |      min |      p90 |      p99 |      max |
>   +----------------------------------+------+----------+---------+-------=
-+----------+----------+----------+----------+
>   | tcp-v4-lru-diverse               |  272 |    93.43 |    0.38 |  0.40%=
 |    92.76 |    93.92 |    94.97 |    95.30 |
>   | tcp-v4-ch-diverse                |  291 |    94.92 |    1.88 |  1.97%=
 |    94.08 |    97.70 |   102.66 |   102.86 |
>   | tcp-v6-lru-diverse               |  270 |    89.43 |    1.85 |  2.06%=
 |    88.42 |    91.34 |    99.04 |   100.00 |
>   | tcp-v6-ch-diverse                |  291 |   108.85 |    0.23 |  0.21%=
 |   108.58 |   109.04 |   110.26 |   110.73 |
>   | udp-v4-lru-diverse               |  268 |   126.66 |    2.04 |  1.60%=
 |   124.95 |   129.11 |   137.47 |   138.29 |
>   +----------------------------------+------+----------+---------+-------=
-+----------+----------+----------+----------+
>   | TCP flags                        |    n |      p50 |  stddev |     CV=
 |      min |      p90 |      p99 |      max |
>   +----------------------------------+------+----------+---------+-------=
-+----------+----------+----------+----------+
>   | tcp-v4-syn                       |  204 |   787.60 |    0.92 |  0.12%=
 |   785.53 |   788.68 |   790.23 |   791.21 |
>   | tcp-v4-rst-miss                  |  226 |   160.33 |    1.12 |  0.70%=
 |   158.67 |   161.71 |   164.23 |   164.92 |
>   +----------------------------------+------+----------+---------+-------=
-+----------+----------+----------+----------+
>   | LRU stress                       |    n |      p50 |  stddev |     CV=
 |      min |      p90 |      p99 |      max |
>   +----------------------------------+------+----------+---------+-------=
-+----------+----------+----------+----------+
>   | tcp-v4-lru-miss                  |  203 |   855.68 |   31.97 |  3.71%=
 |   813.63 |   908.00 |   952.04 |   979.49 |
>   | udp-v4-lru-miss                  |  211 |   854.79 |   48.24 |  5.55%=
 |   819.49 |   928.10 |  1061.91 |  1129.39 |
>   | tcp-v4-lru-warmup                |  286 |   534.18 |   16.62 |  3.09%=
 |   510.34 |   559.55 |   592.37 |   594.51 |
>   +----------------------------------+------+----------+---------+-------=
-+----------+----------+----------+----------+
>   | Early exits                      |    n |      p50 |  stddev |     CV=
 |      min |      p90 |      p99 |      max |
>   +----------------------------------+------+----------+---------+-------=
-+----------+----------+----------+----------+
>   | pass-v4-no-vip                   |  210 |    25.80 |    0.04 |  0.15%=
 |    25.72 |    25.85 |    25.88 |    26.04 |
>   | pass-v6-no-vip                   |  282 |    27.67 |    0.06 |  0.20%=
 |    27.60 |    27.73 |    27.96 |    28.00 |
>   | pass-v4-icmp                     |  215 |     5.57 |    0.06 |  1.12%=
 |     5.47 |     5.67 |     5.76 |     5.77 |
>   | pass-non-ip                      |  207 |     4.80 |    0.10 |  2.14%=
 |     4.67 |     4.94 |     5.18 |     5.23 |
>   | drop-v4-frag                     |  207 |     4.81 |    0.02 |  0.48%=
 |     4.79 |     4.85 |     4.88 |     4.89 |
>   | drop-v4-options                  |  206 |     4.82 |    0.09 |  1.95%=
 |     4.74 |     5.00 |     5.17 |     5.24 |
>   | drop-v6-frag                     |  201 |     4.93 |    0.09 |  1.89%=
 |     4.86 |     5.11 |     5.21 |     5.36 |
>   +----------------------------------+------+----------+---------+-------=
-+----------+----------+----------+----------+

Too much data.

