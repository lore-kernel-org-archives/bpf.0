Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AF73DB641
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964448; cv=pass; b=e7Xfqu1g6bqavEXWZkDwR4qSOgv6BLMI5FFfQTLytbVH9M7V3W0IBcnOsSxvXzhYQIT6jWcKeIiiHUch8xMna3tcTruB2AS90JsHXepzblCpcILbFTXix+5/Yx5EgdjxJG1aRxT/QydDtN4PYFDq3fb3dzowsCRkfpgcjSYEaZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964448; c=relaxed/simple;
	bh=fNaUy4JEgd7bwzjsrzd2PI7TZG2tO9lgcuJ/vKp6wQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFKwRTUeFbWbp/C7Z9GL0DtyIim9q4N5/8jjoroKOjrwLlVTymdTk0p+vlcIwygjsvza7tjs6pjIHDirqbh9tp7uEVI7UCYPFfDVxAf9oAuqZua4RBr3jZWMnoUQhucmFleyLWhsvbpek03AClb5BVpVkfYra/wBpI760UUKs/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=gMurAuiO; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="gMurAuiO"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12dfee30612so2236521c88.0
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 00:00:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777964445; cv=none;
        d=google.com; s=arc-20240605;
        b=Lmbmb6gOxWYz6ceAYHWjvwsV92Mj1SzAWho7KA4q4tI1I21oqgR2V5vmgIDrIYWL3b
         AXsRxcorU42IVtnLC76UiaF+DHYdiA+YHakNQeVyX2DswKEJ9GkZC9VmaGq+BcPVU3B7
         Ihps/o4pcLO2KfaUrvG9eBEbWlEdCW3u/dzp2g9rSFmLRW+XT5Mf2u3wNIZHTeRtZBbQ
         Gswg9o+ShNd/2H39DaDHPuxlqkesW0626uwc4Iilo/I3hhXDeoiGenMrIfQ5ByWDqsh3
         bCJIfs2GRYmg4OVPpcqJCLZnrKlD5kCa/qhBnRSNTAvhT0CvzCIIaUtlloOMLj0SsdzR
         DqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Jm+rYaIrVP077A6xaWFYDY91HFVdV+ekVVmFuHZ77ac=;
        fh=yitGoYWl2f2TIljguNqE/1IxsNyVpvC0TLXfmTHaZ4c=;
        b=DjJr3gF3ccIK9PRulk01DGlkcr0NY00o4kdHDHTIgund+RPZNWnVtTOQo3uakjV6YY
         xS9UXP+Swz2jF7LoSVxKlR8Mv6WD0N0sj/3Savjjj35+KW2q5NwUaNIDGz2k97G7ZlSZ
         mkK9LOFjOI5W56ZNat7yyrI8/nJjssHo4A6LiIqla9tUvfG3KxvJ6XMHmKejCCy0R4Fx
         PeON+4B2xm7mBFRMHfviNm6CvlyRwT3FKf9XLcEZXoo9s48t4DAQbLbHOxI4a178Qwtr
         iHMgy5qClWTh6I620REvT8n1m54jcQhQGN9oBvias09g/rNcREPbI26xKUmYwnKlKq7g
         ac2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1777964445; x=1778569245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jm+rYaIrVP077A6xaWFYDY91HFVdV+ekVVmFuHZ77ac=;
        b=gMurAuiO7KLhzQ1jwf9a4Vbz3r241lOR8CC8cDWSWaKuE4sP42MPx2cUV99Hoy9NI2
         Sjy1wR92b2csCTHlckxgoixrPdrGZshFH5ReaWyvgXKr/qZXLkHJi/KVKQGB2z3m5t9I
         EyiO/3uwlKeezxoIYLrjLISxBuIR79adYDc8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964445; x=1778569245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jm+rYaIrVP077A6xaWFYDY91HFVdV+ekVVmFuHZ77ac=;
        b=U6Rvczy2fMGrjwXzZ7eugdV1JB4dGtKNbWTmZJUOpkHTexA7Nc0rdFi7zyOHsgE1Nn
         HtVYctbHUi4CIN/oZvyng3/ny5MI5QXc6KtSi0Q9aqfeCFJYcMqDwKaGyWifi5s8jPFv
         I10PVoUNFMVoXkUSXVxddI7Lrs0KpOOZJdapYTUu2ZwrWH7RXNNOJ7//L7euACB6eKad
         2rWcP4gLzMPHRe5A7GJ5gSgru5pMnonS8ZLTbgAuL09JX5E1edo0pi9xvi+hfuFuVsSj
         NDy3vVYpTWQZhx1EMEtyEOW+JPUQQglHZeZAlQkQf76bDozcvxqvhJIC34SV0dZvCzoT
         Hz7Q==
X-Forwarded-Encrypted: i=1; AFNElJ8KeufzFc+fdvCe4DNTKtOuFyUjL2PpdkQLIoOOvqJIc7uNBXjRa5jDhrpJM1Yc84tBwN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyWr7S4SKbylu1YUsvf1WvQwM2K/e9ot3QIIaSY3ijvmgVSj4h
	2rtQ8nqI3yyVb3k8O+GEYb5pIafivHJzPVPfkD0lppyTIMegfA5gAvMQYNwl0oCQBT8PIx0rqX0
	uw8TfFpi7Qi7nRqGTZK/0qoU0XTeen99Djiu21X0U5g==
X-Gm-Gg: AeBDievXvGGars85/GSVDu16taMjrLBfxVJ6H3ZABAC0S51gzHZ/vrTugtf7jV5oEX2
	R6ZolXFXIWdfTG5wVg6Cc+4+/363uwqAnmG4P3Se23VzI15MERLpersJOax4v6ivTkLWJKQTB6M
	qyosuhCuwne8mQEO7aEyaRvkmXjmojrual7yM7hKhKRgO9gorHgZ9vcFhOCluvFxxA1TN4xi7RM
	l7eV7JRAs6wT1OQ6mPpg6UQdRCy2cuM2ZBktfVnFwzWF1lWCHAAQRDb/JYD8KRFatxOomOUdvCt
	B+4Pf9B+Z12b+WMkdA8D
X-Received: by 2002:a05:7022:327:b0:12d:ce34:3f92 with SMTP id
 a92af1059eb24-12dfd83a401mr5902092c88.31.1777964445094; Tue, 05 May 2026
 00:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503181504.1037640-1-visitorckw@gmail.com>
In-Reply-To: <20260503181504.1037640-1-visitorckw@gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Tue, 5 May 2026 16:00:33 +0900
X-Gm-Features: AVHnY4Knljmbad1uAV-c-Ej0bF2s3_zZ_vBMVSTnG6PT4pfSJpN8GeS8OCMKyKk
Message-ID: <CAFr9PXnLSM8PA6zhLY0z4ck79EZtEwcduY=K2kLbzRh8QrfP_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] m68k, bpf: Add initial BPF JIT compiler support
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: geert@linux-m68k.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kuan-Wei,

On Mon, 4 May 2026 at 03:15, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>
> Add a BPF JIT compiler for the m68k architecture.
>
> The JIT generates m68k machine code targeting m68020+ processors. It
> currently excludes 68000/68010 and coldfire processors, as it relies on
> 32 bit branch displacements (b<cc>.l) to handle large bpf programs.
>
> Tested with the test_bpf.ko:
> test_bpf: Summary: 1053 PASSED, 0 FAILED, [1041/1041 JIT'ed]
> test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]

Results match on a real 68040 (Apple Macintosh LC475, 1993 vintage):

test_bpf: Summary: 1053 PASSED, 0 FAILED, [1041/1041 JIT'ed]
test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED
# uname -a
Linux buildroot 7.1.0-rc1-multi-00465-g1f6c5a18ddbd #26 Tue May  5
12:25:51 JST 2026 m68k GNU/Linux
# cat /proc/cpuinfo
CPU:            68040
MMU:            68040
FPU:            68040
Clocking:       32.3MHz
BogoMips:       21.55
Calibration:    107776 loops

Also the time the test took seems to be considerably shorter with JIT.

So:

Tested-by: Daniel Palmer <daniel@thingy.jp>
