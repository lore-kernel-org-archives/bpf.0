Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800A747F764
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790941958; cv=none; b=r3sCWVWM+V13qPvrR14U3fjQBXl0uOt05jOgyAolZXY3EwIS2crhQbWiD6uAsYMpp502o9EkbFRXUCIX8ImVEeEFmc/RDX0uoHTVg5xIAkIfX1/5K8VzQO7nv3IQSTt6HiEXd0PsjqHxORjQkvEliRYqyIR1jQigo+NQ9WNh/gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790941958; c=relaxed/simple;
	bh=ZK9W3hsM2fdrVPBcEDof+c76PwgAD673MJ5we/sTLcY=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=EQG57itjrp1jGcepAC3xLIfkV5NjFrDjCIZEvMP059QVs1qLGbJvW/Ia8uKKXDXnNUnT1A2ll9K2JX6rga/5y5xijH4c0/gYITV4/Z64+vCA8MMeJ0+Mny+4fEqRwAwDv0iK0Pp4ZR2DXfqFVnt24IYPEILVQVF6TJfdFl0VYjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goUZhIQh; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goUZhIQh"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2e2e688de2eso26247555ad.3
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 04:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790941957; x=1791546757; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZK9W3hsM2fdrVPBcEDof+c76PwgAD673MJ5we/sTLcY=;
        b=goUZhIQh6T+xmwIT0+JB8OE4Ev2OI+W1B1QvQnPrnbR4slXdPrPelMISBWuSzgq6s6
         2dHWd80pi6Da/Wc1oPU8moB+YkJcefrFFNBlO39OKA0JJW8LnnRgjgh52sbJGZ8FA7Zz
         qBnOwhch0DJOheBhxxTpHc2qMlPLPTBchZNn0TftYojJ70SvDSKxH4yvqWBnRRgcFT3Q
         ibJ8vy9N69AdrrwLYfCrKX6qk8JEBPLy2Ol3Q+xTxZOGeVaBLJs9dcm2pPe0YubjiG10
         oNTQgOQcEQVYORzdIiwZ+Xg5noc5m30zNqOHklur/cGMMFu3Njf5VhoWdxMOS0gkRjQE
         n9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790941957; x=1791546757;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZK9W3hsM2fdrVPBcEDof+c76PwgAD673MJ5we/sTLcY=;
        b=Wgpx21vbCKEB7D+U6JCFbm0qN/11b476b14iO0FPHoknNgaZvFcmeno/AyYPkP9512
         lSJDEIzAOJjeP7yonG1ITAR0ymNg7z8/KGAewL1ymksBVsn3T23RzOxLej6SYnzGeLOQ
         7Z+srwOwwUSKclZZ+f9jhByYs1nC8mQyOmutiunFjhUMUmc4K7lScgnu5YINyRqK/D/E
         xAMJ9Ceb1OlSzEviBAh6BJvtPoJij21MZjEvpg1M4tgCiyeJV3G/wvXuFkly4zPeKN59
         HBOpb/E0h9fxqHE3Noz2TYGWod9bmLBYuEbePsiF3lUfPnpCsJ96eQ6nCAIchiTdF1hS
         ojgw==
X-Forwarded-Encrypted: i=1; AKwUvBzWZSE5K7khU/gAaVR8hFtyFruiaheAGbE+gg1/rOZcdWHCOmPl3CaGBuLv22ovyUwtjKk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+HJXBOpPmgkn4YeNKvYHLB+n7IDh9hDvMG/Pa84pfCZsEh/kl
	hMPQS9BKabKGhXMvXcDgITADlTOSUSHiTmSBNX1rnUMkHSc1YR03jQD8tqnY8pwy74Y=
X-Gm-Gg: AYBFou3tDogrSOfgy1L0mJFix5lJOC2oBA0F94Jw0eT3W1hPk/58kxjy0Mu0uX+wx0p
	oxVpv8mZxXwx+d/q6lZdWMdO8Z/fQJeFmkNfmsEVV4zAVe1KwsgO21JHh9rLC2/EKbI9oMkwv4t
	MVRb1sexiO+C+RdOKniNSGlme4P6NyTKJz0FkFY+dXzvZHLmEmcfNjguw/9CS7yoB4/H4K2tkS8
	gSBk7y3K1st7hcaMlTriNaMMUChtzvupqnVP1uHZPAhQWvpyEUldpqnvoDT82ml5N2AXIPwupD3
	ZEtfU/sPb53uN+IRa2tCWRb1Inn5ps9KQ5ivAASHBHm6P7/dIrlIzzQYiQ1tM6v3m8l8LVa+FdG
	vh5sYuco8PMe+5A99vLfnA/24D+XCNKEMBsdmile7S+37ByHZPqYZs1uzm9ep/fT2L8ohmHMUgJ
	ycCdUL/RlDgWDpxlUc5M5SyFx7PiUnvUxqX9dez5ACQEToiBZrHP0lt4ZNsFhNJ5h8b7BOw02a5
	3ycR9diZBtyTsFPkk6zPSoBEH/xfTf7RgpU5J8/fncZu+xzpfbjnPFhMKcdyyOl6hE4SS13/Izj
	t18=
X-Received: by 2002:a17:902:f686:b0:2e3:ca8:7860 with SMTP id d9443c01a7336-2e49b6436c6mr22785045ad.22.1790941956649;
        Fri, 02 Oct 2026 04:52:36 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6aea8csm6628535ad.35.2026.10.02.04.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 04:52:36 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Oct 2026 11:52:35 +0000
Message-Id: <DLUBXS5ZYG1R.1NA6CW88YS5TM@gmail.com>
To: "Anil Kaushik" <anilkaushikwireless@gmail.com>, <daniel@iogearbox.net>,
 <davem@davemloft.net>, <kuba@kernel.org>, <hawk@kernel.org>,
 <john.fastabend@gmail.com>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <shuah@kernel.org>
Cc: <sdf@fomichev.me>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: add XDP test for per-flow
 LRU_HASH window updates
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261002053837.3494918-1-anilkaushikwireless@gmail.com>
References: <20261002053837.3494918-1-anilkaushikwireless@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 02, 2026 at 05:38 AM Anil Kaushik <anilkaushikwireless@gmail.com> wrote:
> The LRU_HASH selftests (test_lru_map) exercise BPF_MAP_TYPE_LRU_HASH
> only from the syscall side. There is no coverage of an XDP program
> updating an LRU_HASH map on the data path: inserting an entry with
> BPF_NOEXIST on first sight of a flow, then updating a bounded array
> inside the map value using a runtime (modulo) index.
>
> That pattern is common in XDP flow-tracking programs and stresses two
> things worth testing together: the verifier's bounds checking of a
> value-internal array indexed by a runtime value, and per-flow key
> isolation in an LRU map driven from XDP.

Sorry, don't see the value in this test. LRU is already covered.

pw-bot: cr
