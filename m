Received: from out-173.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515A13F6C28
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921113; cv=none; b=RX9D8Q9q/HS6/ZxB0b67RT3iLfKSdwv+gXZ7FUXDtH9bsp3VQljEpEXvEBR6F/B0i5cjZUCbrhsFZXEgMlN59yA/4sYRMOYi12i+oVS9FD1zol7FLWLJckdtUfXOWtgSJ7Xpc56BszgmLz5OrpKIIR76scwb8NUhQe4Ku7f620E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921113; c=relaxed/simple;
	bh=NehMvztkudr8klNOqTTgrkbkrfSik7gzTWbh9JlYGyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ry8epvOt0nz+8G6PKjFwr1+HxnyqlOWi5azV0rCKxZIdmeX6/GEhJgqw98UNgSPWPXcf52f5GNVuRxwkUN/wkadkLDlTB5C03ZnvmdqwjYDqMeG1sOPZH6OaIvJZcEnjTwG64WzV0wK7eZZ+0sMdD2ua6+5O4S2k00Yi9o/VcuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qku8weKZ; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qku8weKZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785921097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NehMvztkudr8klNOqTTgrkbkrfSik7gzTWbh9JlYGyU=;
	b=Qku8weKZ2qe197CAaJhdqDKCuLq7xIEA9q8lfpwFnGsloFxiyx0Pie+Fjrn4vDScY/pYQV
	vofDLjZe5K9QnaMeniFyRYpNnl4PpvlhTfV2vr5yEZpJVEh7Po8S745WY4ooXkWO3gXbY/
	Gnkp0MNs8HwDGg3vH7A37sshwNYdWHU=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org
Cc: yangtiezhu@loongson.cn,
	hengqi.chen@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kernel@xen0n.name,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	guodongtai@kylinos.cn,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] LoongArch: BPF: per-CPU address resolution and timed may_goto
Date: Wed,  5 Aug 2026 17:10:30 +0800
Message-ID: <20260805091030.12257-1-dongtai.guo@linux.dev>
In-Reply-To: <CAAhV-H7aPXsN_jami_2MKJ9CTcpr8YviSJXUxT8s1GMRUEP7wA@mail.gmail.com>
References: <CAAhV-H7aPXsN_jami_2MKJ9CTcpr8YviSJXUxT8s1GMRUEP7wA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Huacai,

On Wed, Aug 5, 2026 at 3:11 PM, Huacai Chen <chenhuacai@kernel.org> wrote:
> In V1 it is independent,
> In V2 it is part of [...] the 11-patch series
> In V3 it is independent again.
>
> What do you want?

You are right that the v1 -> v2 -> v3 shape looks inconsistent. The plan
has always been incremental: Tiezhu suggested sending this work as small,
stacked series -- A first, then B rebased on A, then C on B -- so each
round stays small enough to review carefully. My v2 bundled all 11 patches
to show the full picture, but that was too large to review effectively, so
v3 goes back to the incremental approach.

Concretely, this 2-patch series (per-CPU MOV + timed may_goto) is A. The
remaining pieces -- private stack, exceptions/bpf_throw, arena LDSX and
atomics, and the matching selftests -- will follow as separate series
stacked on top of it. The structure stays incremental from here.

> You can ask Tiezhu and Hengqi to review your patches, but don't do such
> confusing things.

Understood. I will keep the split stable and ask Tiezhu and Hengqi to
review this batch.

Thanks,
George
