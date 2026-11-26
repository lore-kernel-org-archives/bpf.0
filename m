Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795725657;
	b=kLh9beacgY3zKp0MVcwsvBEBOVv0quChOuLcw1M9IqZAurT1eyph3Gck3jr2nyWp3p4f
	 czdiwqhFyBZFb/ycy+o9vbAF1GBhdUocEU2MgTIg/Z9/0FRsz1j6fAMe4NUVEBtw5gyqv
	 Urv5E047x8BBM/UCIvRAWiwUtX5/+PF97eHIdr4t3avcAjTfFz1lBM1DjOcgRzI5Pcsd+
	 QW6zhek7wonx0vYZ5j7IoBjcGm180eQaTpx+Dj8P5dRe+i/CYIkECDQjsNkRY0mwq7MkK
	 YUB+rcwBF+l+eaqEDWKjg/BGQFkHEekzM5xV0eSy0d4FshZ4J775EQIjfeiTxuMofFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795725657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=vhLI3luhSnY5QjC9WSQKZtTBj+4qzkm0fNGEEgLeI6U=;
	b=AP6RiZaD1tt5nT2Vq6SgHxpIgmlP7UAgwyzdxU1EikiRQ03jnMi4eDlHYqQ7CFdZysyD
	 PibCuUEkBQUQ6kfklWeLx9LkfVnA5Fq0dIf5h48ekrfrIYmaDUs7M4wE79qGQ9jkbwf4w
	 e51piBswfM7pERl0yPVsxypulojcpJtI3idFBr65MNUXGL9A6ccHZBTUZeV89Ie7Z1SQn
	 rzSWSU8jQkYO3RFe8RpM+J3ChCpGzind+5vBaPIBKpBXPYGSf0SMviJ5p0eF3M4fML3vA
	 8OsIANsjzvBW2J1wUhbnvcvOPK9FTq2tdXHS/UO6Am8Xj6Ns4BJJu3Uj+hkQ3cHX+ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WbsIeKP5;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FEF606A335
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 20:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62FEF606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WbsIeKP5
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2f03920c477so62021835ad.2
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 12:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795725657; x=1796330457; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vhLI3luhSnY5QjC9WSQKZtTBj+4qzkm0fNGEEgLeI6U=;
        b=WbsIeKP5XsiIBgC8Dr7ZBcZMZ4xF36wK+BWE+MzEtrXP6qc/2PZBrlwGfCAc0ulQzQ
         pe3SALpLm4Xm0f2MaDh1tHFLE0vGygk0K8RMLS8hzVc/Q2OtE5cm4xKT1dW3ry1rPlIK
         XQNkP6lbk9fhdWRv6mkpplEh9lZEx8LT+Yd3asyolPpm9wzq1cokNLWpY6zXHxld8mLd
         mL/jgi0j/zFD5+6AN4T618eGKu1heCfJzoR/g244F2O6RZ7AbO3+9r5oHQzLNh3az0jS
         L1o5m9a4JMmBF6kexKeTHPPo0Kg+aINm1gzZvg1MGX6sdIc5KOgLUy6Od6yDXWspStR5
         E/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795725657; x=1796330457;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vhLI3luhSnY5QjC9WSQKZtTBj+4qzkm0fNGEEgLeI6U=;
        b=eLt+U4dh4LQuyyYNjn5GNp0FtSQjLYg5Jc0yy2Dt76llD0nic3UiTkZKUQbk2jXdha
         gfypMBkMMPoJARVlI58WT1Ge8KS+B2sLwxVIlkV6MuW3BR9gIHl+BMutMi/w2R5YlhBQ
         cJwHEOol82D3Kv0S18TfKmeIGyo0r+8K/h+Xz5RO4Sp21v74K6J1YaY86U311Ni3k2wx
         U3i8yo5Qv0mWFL/OwQyhtF7MCSQYmSt5yjTQkADMBDOPrcK12Ckrl8x7XbIwweqKyiiN
         Vnsz6pKVAEVSthrSJXZ9qIorBB9Vl/MeaOM2N7/vhsofs5HAXJmKl7y6gIIe0wzS4f9p
         tucg==
X-Forwarded-Encrypted: i=1; AL+hErEdo6QgokVF5tvob/RBTCy5oV1QWWduNK4bwj1nwAe5H+379hnnQaVWTHDtSc3FrkI488o=@vger.kernel.org
X-Gm-Message-State: APuU4Z8V6vpZKyoimG5Z0Ie73qAMP67pzodijvmtSrciEAzIRP2yBZA5
	NeTahCAOYmi7uXGSaPJkhaqzhF/HPLzM4Qwq9lvQ3eaQDxztoslhByJX
X-Gm-Gg: AZFdTZdH/2trBmsNt4aDwD1Xv/hfRGW4zvOJBI+LYx46z8hyNHagJiFeXOpyh1EMNeK
	0PpgRblhaO1RcnCY/cMs+DwWjS199VArNoOLqiJJ/bl+2gExbFMqetJYpCHBNUn0aoC8H+rXjFc
	UAgBDCgxGN7d0D3ZnzN5BSnHNWzAmS4jor4gKp/1NrP8AbTLxFq2kqy5VW/2Qbp2W9ZuAgwhIUd
	tdfY1bUaNi3pxHlyGqY7lTpbIaigZ0/YpdWWivhN9NOXwAWz/pZMobyDVCEogXMZE68R6DTjyBb
	HL01gw8f5gBiCjdR2hej6PfcfBzH7aVDW+fg650x7CjRYG0+R94lE40jTeoZDY169Y56zxJkQuR
	cIpqrxp7R0WVi0Lvw7AEAnRytZwuD5N2DwXnH95xT8/oWmKG0ceAhnGSSV0xLc+yeqCHsFiKnbF
	C3Ca8KWC0LwYZOMhb1ybPuDdC9O+5FU9lm+5LMQbMqT52t7bVs465YdEUlH39dKVPLLtvWI2/xw
	BKHY6i3yvWW7H3ZOm6QioI098h/uXxeNyto10E55/8UIvl5M4V1ZKqEoM8k/ckL3gQsk6bQksKk
	eTMvTr0ZjvvibAesXevY5jye4VfHweujEoYx3kMLpcBugP6cmzS/ZqpvtbwFKwKsMT73hTJpJ/g
	lP/axwBv0Rpimop7tD4WR8siNEGkuHNfd6rY=
X-Received: by 2002:a17:902:f603:b0:2e9:8505:5471 with SMTP id d9443c01a7336-2f03ef44affmr240191085ad.7.1795725656537;
        Thu, 26 Nov 2026 12:40:56 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c1a74sm110470815ad.12.2026.11.26.12.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 12:40:56 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 20:40:55 +0000
Message-Id: <DN5FM9P3X2P0.2IFD5DFBRELP1@gmail.com>
Cc: "Harry Yoo" <harry@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <daniel@iogearbox.net>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 <linux-rt-devel@lists.linux.dev>, "Vlastimil Babka" <vbabka@kernel.org>,
 "Hao Li" <hao.li@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Suren Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Brendan Jackman" <brendan.jackman@linux.dev>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Zi Yan" <ziy@nvidia.com>, <linux-mm@kvack.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Will Deacon" <will@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Waiman Long" <longman@redhat.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or
 kmalloc_nolock at call time
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>
In-Reply-To: <aecebb39-47c9-4b0f-a076-ac0ddc7724d9@kernel.org>
References: <20261124060357.11700-1-emil@etsalapatis.com> <20261124060357.11700-2-emil@etsalapatis.com> <DN38HGVL8JHQ.2ZVZQCKFXVA9T@gmail.com> <awWRZ9xCzWLnj_R6@thinkstation> <20261125140902.GE2668804@noisy.programming.kicks-ass.net> <DN4QLI2XAGO1.2DDIFJ49PNRPS@gmail.com> <20261126094403.GA49833@noisy.programming.kicks-ass.net> <aecebb39-47c9-4b0f-a076-ac0ddc7724d9@kernel.org>
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

On Thu, Nov 26, 2026 at 01:46 AM David Hildenbrand (Arm) <david@kernel.org> wrote:
> This is all just way too complicated and shaky, sorry to say it.

Which part?
I don't see any new concepts of failure modes vs existing code.
