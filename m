Received: from mail-dy2-f21.google.com (mail-dy2-f21.google.com [74.125.229.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A093CEBA6
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947518; cv=none; b=Dvu4bWuczH5+ogjwyGUtk1RmyodxOv986xnsk3Lw3TQv/ovF//LGwdL6r+IE+bL2LRDDc8cBdyZRUT9cyvldF3diZVbHqzqxxFzcWtoEVcUCRoiESGvCv60DfEqGr18pitQlvZ9dvp6gqdtxKtmu3Jg7/Nw3FoxGMkYA165+PU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947518; c=relaxed/simple;
	bh=CeUTDK8UskaWLRe6cd8YaVvVkaHfr4p4lFdGwAMcwUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEkLN4qIBDufWAPbMvQ8qg0gRirvqAGG2DTZxuRRaTVlSRcBzJWe6rsxAw++5NU7uLqFnYT6va8SUNuKWicQ8k1B5yOParEQmG0iPd2HYkO8zKFyhhdSXzZ6R6uals18liYok7iOJiCL+0nKRYie/junnITs6VKvrMmbc7GkGc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR6AjEEr; arc=none smtp.client-ip=74.125.229.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR6AjEEr"
Received: by mail-dy2-f21.google.com with SMTP id 5a478bee46e88-33e46a156f4so4570271eec.0
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 06:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790947516; x=1791552316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7RY0E+uq3VziEyUgNcdccbA0uSJfCvboTGuc7W3OBnE=;
        b=HR6AjEErz2PiL7y4spse2vxZcFFHstr7SbrVIzyT/OwIUHbV7yl0K9BMdhxKMpB8ru
         WKMSI0j2u5lNC7cgARWjtOnzsUrLqo2bHbQkfTzkQrz7UD9c4s0/qxkzwOorW41I3rX4
         EYwpfGco0Xux6FyiSzv/LeAvTgSXDqIMQmeRBVDjsvSaKE4hsNCZ/A2y6OWt0xWkSFUF
         H7mGyexvKrkAM6mHSBemQbhcSyteBu+TiQsKa03S56cGJVMa963sPJGKe1sp9t/sf9O7
         Cr/n7E9SVnG9xpgxmv2uV5KjiO8PDgQastD5MDybiPLLr7w0ZFZEBaiLYGY9InnMzAri
         ZjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790947516; x=1791552316;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7RY0E+uq3VziEyUgNcdccbA0uSJfCvboTGuc7W3OBnE=;
        b=mdqyyfYXupTMY0nXYbXk0YEplo6NbPlBozu1vMrtZ6dUK0M4BN2JMC2g1YVQiHu9S3
         zJyYg+4DvrXFQGWIWDdVkVtzlQPdBLjgjBkQ5wIf3fgqCYnUzQPJVx4FcQhlZIpcg9Y1
         wfdaJltFwgq3iBXIefWE+CAybkMXtyHSTkW3zJKJIwizLdc596iFxTFIsT1ZBKuQdThW
         9IsMp+MYOW462GPaCteU85zQH2ytcxBvlwA1GpbBgssMhx8GWT5pmoeBRDRkWD6wVjHP
         xOcBO5DTj5M4k25BPAXRAWpiQb6pxL6TuSsaXRAYdKTbCRSAEhOfVcaMkiT67k6G+vZT
         rwoQ==
X-Forwarded-Encrypted: i=1; AKwUvBy9r3P4BVzoQNoD6Wym8lgLYtiuAaH1BRUZvNBXWHMiBbPLV+0P2dSrJfhXzZf9o42KEA0=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6jO7IPETqJFiP8GZz5HVDQp474Xyk7lAa9Zb7oddxrGuhQYGj
	ARVA73WGSLuIb5VrtRkNEBPQd9cX07ZgqR0oxI+G5X1vRxOQmeAuM0Pb
X-Gm-Gg: AYBFou06q23qwM8+fD8wNw+KLFTVdveS3RFjuqPGJw43RbA9jb7r5TSgnk/ecZcVp6c
	QednjTM2B+NTJK9Tzp2nkUtw5IPkucCoRHjT5jEcAFDk77fXVpy4jQHLiwYusJjGX1dgJ3j2Ptf
	+ix38qP134a4Yke9XqFDX9qj6K7cZROskdw9x8O4RAFuM+9caeDlBRN01etdF49X6T0IlpnxD6U
	yH+Qa/8C9o8yzc26eT7WJLdZFPimYjFvMojNHb519hv4JKVkhUI53MTq0dPEv/Y1t10k8TYDwJ9
	SeJJ7RmzX9tnD9lIJTQlclcTaao7f/g2BpwoN+se6BVLbP43KDvLpDU+7hE9qCWV1OmiENGCzLd
	AYU3nteWvCxCmOI2z+HXf4d5VJ9jpCCv5sv3R9AkgLqXc0pn5AIHpUH7I4SzdQU7tlJ8kyJF6Vh
	U91lItR6UFeQJfqZuc56eMJjxrVtPjrR7AXrUkGk+xX9dDVEok4ePAZE2XWhBv2Q==
X-Received: by 2002:a05:693c:26cb:b0:34c:4f53:60bc with SMTP id 5a478bee46e88-34f15075fffmr2692379eec.12.1790947515566;
        Fri, 02 Oct 2026 06:25:15 -0700 (PDT)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f303e3sm8194198eec.5.2026.10.02.06.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 06:25:15 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/4] bpf: Apply the rewrites of bpf_do_misc_fixups() at once
Date: Fri,  2 Oct 2026 21:25:06 +0800
Message-ID: <20261002132506.4108655-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DLUBNPLXRU86.358M4SOQJIGWI@gmail.com>
References: <20261001-bpf-verifier-patch-batch-v1-0-a12df8a09160@gmail.com> <DLUBNPLXRU86.358M4SOQJIGWI@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Oct 02, 2026 at 11:39 AM Alexei Starovoitov wrote:
> That's not going to fly.
> After this series there are two implementations of the same thing.
[...]
> Jiong's RFC converted all passes and deleted the old code in the
> last patch:
> https://lore.kernel.org/bpf/1562275611-31790-1-git-send-email-jiong.wang@netronome.com/
> Pls do the same in one series. One-off patches can be add + commit.

Agreed. v2 will move all passes to the list, turn
bpf_patch_insn_data() into add + commit, and remove
adjust_insn_aux_data(), bpf_adj_branches() and the per-patch adjust
helpers in the last patch. That also covers the bot's comment on
patch 1.

> That's veristat on x86.
> test_progs loads pyperf with BPF_F_TEST_RND_HI32, and s390, riscv,
> powerpc need zext. bpf_opt_subreg_zext_lo32_rnd_hi32() does more
> patches than misc_fixups there, I think, and it has one call site.

Right. On x86 with BPF_F_TEST_RND_HI32:

                  patches          load time
                  zext    misc     flag off   flag on
  pyperf180       4610     930     0.587 s    1.390 s
  pyperf600       7620    1530     1.496 s    4.105 s

Patching is 67% of the profile of pyperf180 with the flag, 57% in
bpf_opt_subreg_zext_lo32_rnd_hi32() alone. v2 will report both cases.

> That's unexpected. Pls share the perf report.

perf record -F 4999 --all-kernel -g -- veristat -q pyperf180.bpf.o,
bpf-next 6a75c73eebd4, x86_64 VM:

  Children    Self
   50.66%    0.12%  bpf_compute_live_registers
   50.43%    0.00%  bpf_compute_subprog_arg_access
   50.29%    0.67%  analyze_subprog
   49.47%    8.99%  compute_subprog_args.constprop.0
   39.08%    8.43%  arg_track_join
   25.71%   25.67%  __arg_track_join
   24.97%    0.62%  do_check_common
   21.49%    0.04%  __bpf_patch_insn_data
    4.07%    3.99%  arg_track_eq

pyperf180 has 2 subprogs, on_event and the global __get_frame_data,
but analyze_subprog() ran 458 times during that veristat run, which
loaded 6 programs counting libbpf's probes.
