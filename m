Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315BD340DB8
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598254; cv=none; b=OPw8ZwvGnCv+NuBJzp3uY9PUwXl4KbwaWLSS6QF8elvbOryFUp6iYFTL3h1uAxUYneTImDvOSSc0m2Zmtt7ZqsltOajKJGjowpxCYI7NVyXemxvDpE/BoE+/sQWOfReAhu6X3sVQmd+W2LryLMqfy6UyPP0Qg2YaKC2Bn7199/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598254; c=relaxed/simple;
	bh=ymWANid+W9QAIfsP2B7dxOZPLHb025E1MmiiKZKG/Ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnrGK6y0n0sy7d1r5F2oQdTK3Suo+ua6E6YVgKZFRrZZdlU3aoYEmKjqi6thHOmdYmmPt60BEhcR35W+Y50oiygYrhre9588rCO+G+DzGfOTw+IKRC1hPmFPJtUG2Eiqgs00M2BMwp0mftUO7Gw+i9uEPMS5l45UE+qT0gTK26c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-5332048323bso18737371cf.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 05:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790598252; x=1791203052;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XQP52bKkr7Y/wzuKqDsjuqgLw7VrjDizWZT0Wc7gkw4=;
        b=SIoVBZjlCSZZ6EbWIlA3Eyq9Pda+z9KU/CuwOFk5Z4RBe/jKiHCr+E/a8HEIb2oaDp
         wrnRWc0g5rck+6PAOoQ14IIo2xq8xw9XGyONyUBciVmii7EUUqDLY4z1tooSatz+xgnH
         mRs/QdvQjsypd/AiFzsBcrSsu9SsD3r9zfRPV61V598Ns3O0ZYymnzyyKRp2M+prPk+v
         KOQ5JY6Yxnq137KI9z1AH//ToVLWoNBKIbAtyMNqj0ll8aglouSYOtyG1C/mnxDXiKD8
         2olRCSKTB+i9ygxt9wFRL0vVgAwUknl2IUp5CnGFZlvcCoZ9bqZ2pV3ARTyhsqiaQrr0
         7Nag==
X-Forwarded-Encrypted: i=1; AKwUvBzcD2mvAS063/0/T+yx8vWgALqIyM+LFELPaONctlS33dHm7dgmR2aHibg1ocD+PErVgak=@vger.kernel.org
X-Gm-Message-State: AFuF++m4edHJpYRhrq4T77iLUiGsuKteSz+RH552FAlrsO9OIjPyeKpt
	CrU0HbaY57a5YApA4+zeveWY2PmuxfIPvpK5MtG2UZzoWd2aQ6mL5SuBguXS0HD/
X-Gm-Gg: AYBFou1AEZX7yEVUz4Ez1BrOva0C2nn1IbZYZWwI2RVR6VK/wEaCDudTzyE45mJHEJQ
	fk2BSU3KoJAs9o/o44V9anzgTbPBS3pa0R2JQucrkRYkRWejp6kxuw6Gbk/zAzH0Ozd8P+V0sxz
	/K0xFsmx9ymb5U7XH0HUlo5Nk+dqy2bVaxZ143PaZDe/l27aXPvgjMjSBrTqRfttcxvcu/HDB6R
	Lg0xyNfVEsyLCzpxieD6503vFa7hxxrUYRaujKlXU97b62lRvfMVitFOKtUaTrEbNV+7nPCdCpp
	CJz8fnHzgw7CceGC53tnXnxFfNIpUlmv+QLe03yMjJANihj17u1DcuRXbvn5sdL3xEQQTh7JdH9
	pWOun6RbWnDvYjdkVXE9abTRSU+66ZhFeVUK8hqQidcodafU/5w+K1x33kPQMEfdoazMlPUXGk2
	jFEgOraneORHTmx42Um/h/AWrFt/p2DJkFDPBIHtSxCyer/1TxJWSdJtJkEyVybysPR+Na3xOlT
	0SR8ANspCUtDBcMSvqJGzk52VDKgKr0o9CSYw==
X-Received: by 2002:a05:622a:107:b0:530:b2e4:4e30 with SMTP id d75a77b69052e-5330b6d4a43mr215998331cf.61.1790598251839;
        Mon, 28 Sep 2026 05:24:11 -0700 (PDT)
Received: from mail-qv2-f42.google.com (mail-qv2-f42.google.com. [74.125.230.170])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-533224454dcsm62984991cf.31.2026.09.28.05.24.11
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 05:24:11 -0700 (PDT)
Received: by mail-qv2-f42.google.com with SMTP id 6a1803df08f44-9143e192df5so22241436d6.3
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 05:24:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw/Tu32/hw/vnmeNZ1n2mvkcsErQSdOdC5GIf+ZvZghWk3kwIHWuo6CpjCj/HVe8U1xJ54=@vger.kernel.org
X-Received: by 2002:a05:6102:6883:b0:7a7:19aa:8a83 with SMTP id
 ada2fe7eead31-7af1ecf279bmr5070898137.30.1790597755270; Mon, 28 Sep 2026
 05:15:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927205501.672807-1-visitorckw@gmail.com>
In-Reply-To: <20260927205501.672807-1-visitorckw@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Sep 2026 14:15:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVcpHrxg_Kb1vpguSYbRg4CU4DxNuPAv3UqHNHZTNk33A@mail.gmail.com>
X-Gm-Features: AclHuK85gzWq5IklKOwAQu80W0kMa7pFyTsMwsvdeVooaKjfbbGjxmEBQYgiP_k
Message-ID: <CAMuHMdVcpHrxg_Kb1vpguSYbRg4CU4DxNuPAv3UqHNHZTNk33A@mail.gmail.com>
Subject: Re: [PATCH v6] m68k, bpf: Add initial BPF JIT compiler support
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, andrii@kernel.org, 
	gerg@linux-m68k.org, rdunlap@infradead.org, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, ihor.solodrai@linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw, marscheng@google.com, 
	eleanor15x@gmail.com, Daniel Palmer <daniel@thingy.jp>
Content-Type: text/plain; charset="UTF-8"

Hi Kuwan-Wei,

On Sun, 27 Sept 2026 at 22:55, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> Add a BPF JIT compiler for the m68k architecture.
>
> The JIT generates m68k machine code targeting m68020+ processors and
> coldfire parts with an mmu (ISA_B/ISA_C). It excludes plain 68000/68010
> and non-mmu coldfire processors, as it relies on 32-bit branch
> displacements (b<cc>.l) to handle large bpf programs.
>
> Tested with the test_bpf.ko:
> test_bpf: Summary: 1061 PASSED, 0 FAILED, [1049/1049 JIT'ed]
> test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
>
> Tested-by: Daniel Palmer <daniel@thingy.jp>
> Co-developed-by: Greg Ungerer <gerg@linux-m68k.org>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Changes in v6:
> - Fix kconfig sort order for HAVE_EBPF_JIT.
> - Update eBPF-JIT/arch-support.txt

Thanks for the update!

Are any of the issues raised by the bpf-ci bot valid?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
