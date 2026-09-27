Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1E13BF660
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790542497; cv=none; b=oot5ZxtKuxBSvrYdTiii+cvrz1iajq6ycTllYyAK1irjxg7TK1muJC3SxtDpIewbRm3sOhvY6EagVyA7AE7RO1X1tyx5AzKgwxWyvotijhrbs3wETn4QAU7sioo94b8l0x3QmV/Dv/kraqCd18Z0DxmK8J8JEYhyvBq38Y0qEyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790542497; c=relaxed/simple;
	bh=4s019A5XluhkMkodS+DKuqgV/LQVvPoIHxE5EgwLkoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKKVv6v5CRJVkCnZZxBRmMgrnR9H+/eaejfKrv0FsAYTpi/JBJyfKtfUplia47ugXl/XbybITZHXUuVRzgTtjCFsdFJV1CWk/qlIUvxSEsGaxUHalB1rSYmtwWROug6R35AUAmRq6R4uh0ms/sl++4sWbVq1TMTpwBHwsFR7LCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV3zEtr2; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV3zEtr2"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f15b78so2057385e87.2
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 13:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790542494; x=1791147294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4s019A5XluhkMkodS+DKuqgV/LQVvPoIHxE5EgwLkoU=;
        b=cV3zEtr2GkUYkAwquKR33xd0jNIqbUhwVHyIWW27cQ+MNtVaP/RmpMuFkzRFJr99S9
         adxW5ZtZ1zL6BFNZhOFK52bvITzGeNfNF57fda/N7BbRRTC8klVM8yRcyQNFCx8FKHRo
         Fm9yWMYBs0h06lwmBJbDgM+w6qGwykLnKj03SNC2o6sUKA9zCNfDVzm2ICVC9pu0ijpJ
         Ds/EpOv+dxdYLvEfQ+7sF0DkRYC7n/Zl3Q54OJ6LAfHOqhWPKKM4pixA7rx3p6ewBCIg
         7MDX46+cbxVOj/hefojrjtRYfErXxXR2/4VtA5P/GefvmYxoxy2M6xdzYv8Q/PTZLw7p
         KoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790542494; x=1791147294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4s019A5XluhkMkodS+DKuqgV/LQVvPoIHxE5EgwLkoU=;
        b=jwakUykBN9E8h/yzdqRw5RWDikO7rLrnTAUiT1dr7jgejGLMuVXHkGphGRyg04FMzX
         ioDgxWm2y7+NYQ7MW1LgdknOxXRW3Cwnmh2t3hjHkaK5itqz8mI6MwKiKVo0YvfrB12o
         D/5a1lZ5z/6FVpHmHvFu9Uooce7ZwCZoJJAuEGAiAgJSUiKbcaM+224pZOU1kuUKxsZx
         vGqI+mOOrTs/M6knGWEQBgvohKMwZR4JdVprhCzteZKXkwkbFJ9k+GsdYH+fnPzmv2f6
         dUJPX/NPh+H9fYlPBdDW7aYtAtR04Tllr6px6DjGnf+daS9gWo+4Q16jOA2ZPeaH4DlL
         BcQg==
X-Gm-Message-State: AFq9FYKojdG0PPitaiZVwz9dJdQPzb+gU9FZC5pLVVMdeZhEPShfjf+b
	QEKEScG4Sdt+8woVqJ+iXRrkfX84pinsLTWNUj6o6chnzMwiJSt0Tl6YWYhOWngh5Sc=
X-Gm-Gg: AYBFou1gdU4Hz/E2C0OHZD+TvRSXFYOTHrPIr5LfMalvoIrkyGHk7VmVGhyOx1/EiZE
	zylplTfE+HY5cs2Swzz3ecdocQQ5LjbcajvID7A5EQiJlvA0SC8JgmSSLkrFXXHWt3DSw3Ys8QX
	ITl2wxlDSQ6+VpW2lBRyaKZeT0EcasL42kGxueQfYx/ddcaTig/xkuyV+pJ4fjPMfEpi8dgpQlI
	4MrQKGV+idiyY2BWyRII3u2DgPZipIUsoMf13I34zPjjNHSnmjgrvuG9mKscH9uXuFCiJIgpQck
	r8ztBq86pQMaU4DNE1r0oxz+KI3Yfv/HDSDqeXELBg6khsozK0MEVZUEUb0CVjVJDSV87qdDa79
	q/c8Gvp9dRlbHZ1lCVr7Y7BeRZInueHF0w6CJfDuJQnn1LFjxbCZ6vwpO6xWfEa8pcEpWTk6WFx
	HP6xvOf+XN3tHxy1/qtH1d3TLni6bCIrbQW462KdoD9UNkyuUrl2JMWQK52Xx99z6DK9NTRewXp
	DIpNyMkOY2xJtA=
X-Received: by 2002:a05:6512:3c84:b0:5b6:19c9:d7b7 with SMTP id 2adb3069b0e04-5b8df0e092dmr3242374e87.26.1790542493568;
        Sun, 27 Sep 2026 13:54:53 -0700 (PDT)
Received: from localhost.localdomain ([80.66.93.59])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8e6b01b38sm2050914e87.54.2026.09.27.13.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 13:54:53 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: bpf@vger.kernel.org
Cc: Maxim Skokov <skokovmaksimevg@gmail.com>,
	qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	kuba@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	hi@tychen.cc,
	martin.lau@kernel.org,
	mason@kernel.org
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Check that bpftool map dump fails for socket storage
Date: Sun, 27 Sep 2026 23:54:31 +0300
Message-ID: <20260927205436.107097-1-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <ed8edf2cea6ce83f46358c910ad9315650cec3e36dca87ea46de30c43ab06a75@mail.kernel.org>
References: <20260926170149.541352-1-skokovmaksimevg@gmail.com> <20260926170149.541352-3-skokovmaksimevg@gmail.com> <ed8edf2cea6ce83f46358c910ad9315650cec3e36dca87ea46de30c43ab06a75@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Someone reading only create_sk_storage_map() would think it returns a
> populated map. Should the comment say the function creates an empty socket
> storage map, or move to the caller where the element is added?

Right, the comment is left over from an earlier version. I'll make it
say the function creates an empty map.

> Covering the count path needs a map that has no BTF and can't be iterated,
> for example a queue, stack or bloom filter map created without BTF.
> Unfixed bpftool printed "Found 0 elements" for those. Otherwise the
> assertion and that part of the changelog could be dropped.

Agreed, local storage always has BTF, so plain mode goes through the
BTF writer and "Found" can't show up there. I'll add a queue map
created without BTF and check its plain dump for no "Found" line, which
the unfixed bpftool prints as "Found 0 elements". Both go into v4.
