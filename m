Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6294547065
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790411357; cv=none; b=EUrcPXUzrQdFkIUImCE0jNVplb8L0Xh8+404ZipW0hIxdU9/khPm5rn7fJ0odV+QtpV+2CIHmYyYSEHH4BdDWOQwc0j7rOzfhoqucCfSDU2nGUVtOWYx1ngl1A2fTLD6qp/kJ6AmDzAgJSDCx2mfn82Wyc9kVbTdEcICwLTRglM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790411357; c=relaxed/simple;
	bh=iXM6dXLVZyc4/2LLEhMvfVIyG+SHsbmujZvmS7fw1aA=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=Imp5tjLc+w27YzvUUurFqeiQhVNxN8hnpMbJMaiRrnRn2ddABh9GlFk84aUpO45NoMUFbziI0pgnoY2jUu08KwT1k8E1M630K50cJErKqc+jUlvg6ko6Ar+Ciq8tRCu2qWLbt1ipe9zgFaHqVNULPFuMuejpDFuAnrPZob8pUv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1tf1epb; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1tf1epb"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb65437so948696a91.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 01:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790411355; x=1791016155; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vsTzuV1eSC7imODMsDAQHQQbWFGBD/RBt6ggI0+EwhA=;
        b=L1tf1epbkhLphZ2Julis/OkRu7jj8hETfwJ/ktaJBK1t/FnSaBM+B/Cvk8BtSprulN
         LiTnhae7M11zRQ6WNQLA4WD/vdDuj9nRTm6pOICKA34Y+2mvG7lEMPdf/57cRfUjmJX6
         P2rasuRcLzwNc44BxJt5lq3cNRMHqcft+eB5yHVdTfE7PNWyZGhs+3HMjk3kIg6caRpT
         TGpyYMVH9ya+B8q+vDF7MM77tQM3OGKVyRiQA+4au42hbq6b0SM1/zlrAQ79jDv9k19r
         Vbp/FjUWRznjhLnpVPM25BQ9x8aTAA+8zE8wL6H5I/RceUNK4KJzisdkbOMQL49P0+7b
         o8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790411355; x=1791016155;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vsTzuV1eSC7imODMsDAQHQQbWFGBD/RBt6ggI0+EwhA=;
        b=Fi35xV17yI6G5A9dyiCPtZa5PPtUT4jivEbO0ney6yjsSyLNK53Sn4ibx4xHDCfIOG
         heAsU8Jy7Xf8qbN+6HvmXrYaB6vvnPQ5nNkSAe4tkfIMpybW3sEe3vhmjsPiWe4kWvJu
         BjlCEz156w8CWylZaIY2v+HCEK1aGL6j9ajkONxBoIAtqE5DIObStdNosgyO1EfpsV1b
         OshUJcuOF45wkmSa453DhClsCU6Ei91rhmnJ1F8nlbzwZkmDjdUZhD8WrDU4F0CvD6U5
         D7CF0rKoRhqTJgW2BDJXu9sgrwo5IlH3X3Pb94TA/zn3K5YryaRedaFBychZ0VySrVNz
         TKvg==
X-Forwarded-Encrypted: i=1; AKwUvBxPHTjkh9WmOSlYzDIz96z4UKmnRgzu9MDTkRoq2rQuEH8FwQrfWeJ0bOq9uMC1CyXLShE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtOb+Zels7rvpULq5hTyPtU1qK7RH0Z3trkvNYDoeYLVLfXWpJ
	ApF6eTIabrM+lEJ4om/PFwASJIeSwIq1odH9vslMlzcYxdTvBiM936hl
X-Gm-Gg: AYBFou1uJ/IYKV3nWr9rxqmXzzE7I7w/rRNEwXJ2HZFOruN7I4DJziw1+kcKitqZlzM
	Di1aP0JudZvWLlZAiHRRlt394nhuD8g8jpMQb2HKviSHx1pZ9baFfeOo7QA7HRN3jEn2xdO/bP3
	k196LO3b5W8IEknDz0D+0S1ijPkTRTrX8r9lmjvcVvi7qgqoB2yzyhY/+pwTiix287pE76BFsdC
	16PQmZjmyFVDabqWERrk2U2CaQHTe4TDDC9/pvk22Y6QDDcx0YXxZbMpGSqTRapzO7DO/CngaCY
	SiOMaTOt6EdHcyivn55eEOpFtnQCrhKARNoP5YwSIGPCUu4O/JdeNx62wD2iW8f+QsN3z8VJomp
	cMK21aFCdKcg5EhfYsvAiGtQVQoMrN+1Bf0yMZlyZElETthOePZ8eEIs++0av47jYbF0zyQbbOh
	2MGFYoniPTItxS78B1UQDTH/0wYb12iXyGlpMPW+9xKWOE2JrFuVk1ej4LT6/eenFIT7BTMPYCn
	4zge2S0/VxPbHKU6DDHZlA7g9UwketauXwuMWIs8GaTgyZxN0hKJu+9q/VaoeMZtGHquTPcsuhe
	bNBP
X-Received: by 2002:a17:90b:51c1:b0:39e:1692:34bc with SMTP id 98e67ed59e1d1-3a098ad4cd1mr6277315a91.1.1790411355026;
        Sat, 26 Sep 2026 01:29:15 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b99e5220sm8692077a91.16.2026.09.26.01.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 01:29:13 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Sep 2026 08:29:12 +0000
Message-Id: <DLP3USQDIMJG.1FUZXEXOX38TR@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jay Wang" <wanjay@amazon.com>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
Cc: "Alan Maguire" <alan.maguire@oracle.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, <linux-kbuild@vger.kernel.org>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Sami
 Tolvanen" <samitolvanen@google.com>, <linux-modules@vger.kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, <rust-for-linux@vger.kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, <linux-kernel@vger.kernel.org>, "Hazem Mohamed
 Abuelfotoh" <abuehaze@amazon.com>, "Bjoern Doebel" <doebel@amazon.de>,
 "Martin Pohlack" <mpohlack@amazon.de>, <jay.wang.upstream@gmail.com>
Subject: Re: [PATCH bpf-next v3 4/9] bpf: take the vmlinux BTF from the
 btf_vmlinux module
In-Reply-To: <20260925224229.1850-5-wanjay@amazon.com>
References: <20260925224229.1850-1-wanjay@amazon.com> <20260925224229.1850-5-wanjay@amazon.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 25, 2026 at 10:42 PM Jay Wang <wanjay@amazon.com> wrote:
> +	if (!data && load) {
> +		/*
> +		 * The module notifier installs the BTF before init_module()
> +		 * returns, so it is either there after this or the module is
> +		 * not available (yet).  Not cached: a later call retries,
> +		 * e.g. once the module becomes reachable on the root fs.
> +		 */
> +		request_module("btf_vmlinux");

This will deadlock.
event_btf_ids_read() calls btf_get_module_btf(NULL) with event_mutex
held. With =m and BTF not loaded yet
  cat /sys/kernel/tracing/events/sched/sched_switch/btf_ids
gets here and waits for modprobe. modprobe gets to
trace_module_notify() which takes event_mutex.
lockdep doesn't see it.

print_function_args() gets here for every line of the trace,
from ftrace_dump() with irqs off too. When the module is not
installed that is one modprobe per line.

Every caller of bpf_get_btf_vmlinux() and bpf_find_btf_id() was
written for a function that doesn't wait for user space.

pw-bot: cr
