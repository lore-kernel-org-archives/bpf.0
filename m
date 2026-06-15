Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FF140D570
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781481906; cv=none; b=BaOQNufczM2LB5H/eRvBnZhMSj5peHHNMt2RXgJY02vduYAyguq4QYsLhvktwj345UaCk9UqqpaNDlxfMkqocjsNAZZCz0sLf9UAQ/bKrJt0NkyaGvhpxRKUVFxkuIybpxAtBbZ+DmIMHwg0h5IWBukviXZykfMKdtB6kB7BvlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781481906; c=relaxed/simple;
	bh=+sKO4BRSMEHnKqnwGPSXTQjcdkJi213RCzRbiN8vh3E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JumrMeXa0bNEi6h6v1yAH19AAEFTOLS2lw96f/u/d5Y0fjjCTFnX9MSO3fw0B+xNQYQrU/YavpX9wbBeA8HTUz/+V7Etu7u0juECAzdWFIYQFUCOkcuTPSExRwirjuY94wF78h9eW+se4xZ1VNIiajRcSnX9FggdAQi4Z3WDGP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzYUiAfH; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzYUiAfH"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e71dd64ea2so1607604a34.3
        for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 17:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781481904; x=1782086704; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49/WFGBQV+h5/Hr/WXvhLPsB3u7z9gZgu6pPYMhYOFQ=;
        b=HzYUiAfHmZKHyNcSj/2Oomygj6aJSqgSM2hLpwhugf90Qnp+MMn8UAaQAYc5LIqKfx
         wwUcPmc0TI0Nr+7r6OymSMLXQ1i87VoK7ZJTHbM6SMjZdfb08k+hae+Jkwtiq/zrw3ob
         1B+SFkDJI1Njmd/K9kvG7JRysT0Vao+0ocSvBL8Pq8FUBNe5RjldSpjKXIYwyRbm4J7b
         krewGN3myL7EEvZZ3aWPgGWQGycWDt08GMHk8KEIyyONiN13bKOiu3QMQ/E7KKdG+S9K
         lKDet/lwF3af4a22gEAb4BtCBj32l0jDXnu4p5H+2kYHuqQ3RzJEtaJtiMgUPn3LcS3D
         fp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781481904; x=1782086704;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49/WFGBQV+h5/Hr/WXvhLPsB3u7z9gZgu6pPYMhYOFQ=;
        b=Ev0kGcKUIQ3OgBn/1GJQ2nDF0EKpM3MiRxqrdhDJfbRJaDfm/3Pt7iuhV+MK5UXQ2c
         0jE6z04MBpziRlbXkk16rc4+btHqbfeyfRjQkNCP8Hw68o+5IrlE9a4NAGcdIi9s+Faa
         luA1oBRK80tNtumIdsxxjgZZap2dF6ex3qiXJsoxd3JBYwWDPjm8NcTql4ArqQk0vgRD
         6CjRAeGTlB01G/XD50jx9sJr6NauqhtRslPS8Hl9KYaHqLGtXhvveGYJ5JJTHMrLfjXC
         D0qcfWVU42yDt0vIU3xt2Qry9sLj5nLSzTonEQpD+O6rC8aCqzV3+NHt50TQoU7DHAqo
         isbg==
X-Forwarded-Encrypted: i=1; AFNElJ8YScqA2NN5w9MMrN4f2qN8PgtqK0pR5Sty6OLVCFyTGWYjFPjLwazqzmNFss6G3NNZvUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQfk7angULib1bIQbZRcVSWUvQp+9CgUS0XDAMyOFOBj+x1R5P
	2b3WuGDIV5gIzwPDA+YihD3mhk/fpxNV/A5/PmFF/eX5kUUSPdVFeBEC
X-Gm-Gg: Acq92OG/Xgmj2+Z7ZbbrgpeTX6nwkjwS+kQxG5YJ5WUZVyy0MmTViRr+PlX/l/HMNoQ
	gGHSTVOF62cMhEzNQmQAt8QX3bqJEYrBwsvPJvfoQF357c6TkdJVj+0Mz9oORftVXjvFBPvk53Y
	XKJn3QWlh8lyIxXhbRtUFUpK7mDhPHQYz+Mv51H0RLaETG19lnquXJOx6q5u5IaBYXhueL+Xk4j
	GoaqGCJANFgCbvwur8LSKb6Q3+kRK8b3tssGGHj41JTK1cMToW0xfydV1p7Pt2j5gDtSiX+vj1U
	1yFlDd/G0+2mo+yL+J5E3R5CBl7tzobw4EivtmRgK57RbJlsB//P94wj72VsUxr7/UIWDCutY1u
	0n4CJrGyNI+qDzBuJ3pN0lxxX48pdLd4H3nt9eHdexUpfQthrHfqd0T9F7MnD6tGjodCDQ7rBCL
	pPKlF8lTKCGk0obnIgRZyU9ZhJNco+uP9H1W6aRs3k7guEpKdpi3eMxh0WfRP7JYlBIhlah0k9g
	0A5/ioRammsiqUVxg==
X-Received: by 2002:a05:6808:1998:b0:47c:be93:9214 with SMTP id 5614622812f47-48741b03cc5mr7019470b6e.20.1781481904332;
        Sun, 14 Jun 2026 17:05:04 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:51::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875df7fc36sm1762551b6e.9.2026.06.14.17.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 17:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Jun 2026 17:05:00 -0700
Message-Id: <DJ96MMRGKH4E.TEU7DC2PNB7L@gmail.com>
Cc: "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH bpf v2 1/2] libbpf: Reject out-of-range linker
 relocation offsets
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "HyeongJun An" <sammiee5311@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>
X-Mailer: aerc
References: <20260614092616.165337-1-sammiee5311@gmail.com>
 <20260614092616.165337-2-sammiee5311@gmail.com>
In-Reply-To: <20260614092616.165337-2-sammiee5311@gmail.com>

On Sun Jun 14, 2026 at 2:26 AM PDT, HyeongJun An wrote:
> The static linker sanity-checks relocation sections before appending them=
,
> but for executable target sections it only verifies that r_offset is
> BPF-instruction aligned.  It does not verify that the offset is inside th=
e
> relocated section.
>
> A malformed object can therefore pass an out-of-range offset through
> linker_sanity_check_elf_relos().  When the relocation is against an
> STT_SECTION symbol, linker_append_elf_relos() uses the unchecked offset t=
o
> find the instruction to adjust:
>
>   insn =3D dst_linked_sec->raw_data + dst_rel->r_offset;
>
> and then reads insn->code and updates insn->imm.
>
> This is reproducible with bpftool's static linker by crafting a BPF objec=
t
> with a 16-byte executable section and a relocation in its .rel section
> whose r_offset is 0x1000:

libbpf trusts ELF.
There are many way to crash libbpf and libelf, for that matter, with corrup=
ted ELF.

Please don't send such hardening patches.

pw-bot: cr
