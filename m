Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864362BEC3F
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 01:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772759530; cv=pass; b=aN2j4ayBzDp6J0k2vnCdjNQEx19P9Uaghi8URgqdDhtslzu1StxVMYAqmE2hBwVUcWbXc/s+dRA+c9rddXWYXhov+VcNpyhdDhYskuGj69Ij0RGafETdqHDcaN6ZlWbEWwEcPjHLnB1GUH/fOwPj1YQvF71NoTiTb2I8FKGyP0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772759530; c=relaxed/simple;
	bh=LKsfKZLiAVaFM1GdMicLiCeFo5n+vxBb8xtLWkBQQvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dg1BuRnmS13FLyUVCNAw3coZiILRO1Juf/BNCz/TPe7HHxzzvfjxLW9KX3wQHYXLEOZFDAxNCeYHhz9UyZgAjWyIjvjEluzmIZBtu//zF44IxvgLlo1By9glOozeRI6RDpckXOofOkEYjeeo3pWPafyoiMAdh9mCCU7W8OsmZoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMnxSzRC; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMnxSzRC"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439bcec8613so3579109f8f.3
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 17:12:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772759528; cv=none;
        d=google.com; s=arc-20240605;
        b=aTXxEie3sbDP33rc7lU8lW25SeOCNI3dfCwMVAQQOqDTJ3FGuw18TSyrVyIDU0dfTv
         B08a1VeNimJII/beFHlkeJ4EW9qyIaL5tFOuZenjzZF8r5PUq5r1Q02n2FM04DbKChfG
         c3nGEeam4fosZw6MtZ6TJujg2r8DjhE/z22Dxy+jRg1t6K6G2EvIbEl5tvA2uJw1WSgc
         jEOA3klsCE9lp5wNsGYmMYMR0qbUH1DNJ0t/9W+9KuouZHub2dV3LOVNOaX/rJytvPvl
         6gzntBgmQKJ+Wsv7T+eX69+jeVdqxY/82HY7NJnk09ReicXhbW1D/Pmb8nf7JlunWr9P
         tZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jqtr6l6dTbk1EKeU8q44Q4dTXEksnT7RE1HxvD/CajU=;
        fh=QWPamShyA1J/8s5doFWE3PWqLapUJDuSRevdrJZqM+c=;
        b=F3Av0Mn/+O6Y2IGv0GeyKfe1XTLNHNcz8YhVreD2cYQQk93eSX1+3uI1aP6noZbeX+
         GYvy2CJS+KxUWN+q/mM6+58N+TF24Mx5Nft4WrHUUqpYnyADGVCgSLvsNioAgwR3EEnw
         WTTvQPT8gJdNJK2ow4En00BY5RhU9Qe25lbxO6MoKyU83g6Lo8/y6CmH3NLFblAYU911
         bcwoMV+jUwvpP12ujFmZLjBnf+2sHog9O3ZUzM7olln8gUSyUTwzefTGYzQLU27jIpTT
         0i4jKGeZZw3KzUzYFrQ9a45Vxk5qxrpmGDt4CSVF4rtthix0AQNV2eWbbLnQxwLszPYD
         e4hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772759528; x=1773364328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqtr6l6dTbk1EKeU8q44Q4dTXEksnT7RE1HxvD/CajU=;
        b=iMnxSzRC6Vvc63zkk2aawdyhq2saD5fnjVuPHHqD8r9LiGEeisfM/pvZXqSu0FAXKe
         7R4k3ZJRYWVC/8+0H0ldmstGrGuNwVG3PxveOGH+JlZ7HdnrwyumhAEgpC+9WlR+siIT
         /S9lZQowQRoIW7E6vSN2lkA5vml/nT9KXuDAvPLptNkdBro+lRr1SXMNT7pV/jlYh2nV
         mA0GXpohLm/rRyaUlafmy/JuJWJKq24QS/HeO219xOE+GU7Vv3NMYfrdzyamNiBu00bA
         /PJ6nJSR7qZl/XWnczL00ZP1KPuPztF8QD/pX95mZ6uYUBb/WCENL4JMbU3yO0yyRD+j
         rkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772759528; x=1773364328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jqtr6l6dTbk1EKeU8q44Q4dTXEksnT7RE1HxvD/CajU=;
        b=rB4C7zn07W9V2HUyWq/ytjHiPdtyAp1F+BW+n2UB0OarvWPVDwf2KjeJF92q4VgJ83
         oRdgq7zws+Bd1E2tZKFTWQ8r0cyEMUeZAQz9Y0SPQ9oaPnvEfjCTapsu1S5c4Lmu2Mma
         h2ZamSNI5JQ4tY5EtGULnTor2Xw7zLFo1jt5wVVntjoaIepX/W9I50k3LASweIkx0ZWs
         hsFhIeq1N/V3fH0qieNnlQ89O0cNlPdzNlIri3xTypivonbXSYN5NFaC3tliw84muAJt
         NjBFt/Z4F+0sQWVX/0efT3BoLeOn77diNCdgJsAQPvTVtKGnIXtPvSz2Sb8pbqGCPIHr
         82rg==
X-Gm-Message-State: AOJu0YzZ3Q1YOfhbTIoRnmKrUxWOxbEVaDK/sjb0Duh4iRRi4ZOSPjjQ
	06GQ/GJxHgMGTHlyHx69Fvw7kNVUgHv1D9gNXYSX9pSRX31NfvTTIcMnpw3htb4HKoWiF5Exjep
	60JJciwbBXkLFEne1U/rEd3nLOu157ME=
X-Gm-Gg: ATEYQzxYbA47oyECySS3wO0a7jgb5s6rzpjtvZ9eRc8h+/vKuJfMSp4JQVl3Sz0X7Sy
	ATm3XlCFZ/DxNhIST0sfX7kmCXB9j8OSxXEwdMK/Og2R7n8ulY3dHUU5qfJLTHA2XYvuxqTqu45
	wAJ3YsScIMT9PNrlsK3fcCSRi68CWj9Md5zSUJmRqiGdHJUbXGhaCq5SXNwT0jwJLdol8qjqBOb
	1F5fnwilHL7746L33i0OXrVFCBq13MWj5lg6aC7YPLlZBTk9EpZgkS3a19kDHJ4V0sIhFmIvuuF
	QwB7kE4txUqdIGeiMR4rlB1hLbEaIyArqaY9EztALxSjmoI1uNiGQTKBKw5tEMymjEL76m8ieCS
	vGtTf7F+jNVpUGsXtTB/YbFp8Rw==
X-Received: by 2002:a05:6000:230f:b0:439:d755:a894 with SMTP id
 ffacd0b85a97d-439da348b29mr502592f8f.3.1772759527803; Thu, 05 Mar 2026
 17:12:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304142026.1443666-1-puranjay@kernel.org> <20260304142026.1443666-2-puranjay@kernel.org>
In-Reply-To: <20260304142026.1443666-2-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Mar 2026 17:11:56 -0800
X-Gm-Features: AaiRm51CbDYr9z8GjsTZaxrbNK3SNmtg9g8hL_JLaYcGCVvsywudE8rPeEG6AJo
Message-ID: <CAADnVQ+U2vK1gV9T7jtQTE_6x-UUOSH4z4EiUC5+OVvW7nfYwg@mail.gmail.com>
Subject: Re: [PATCH bpf 1/3] bpf: fix mm lifecycle in open-coded task_vma iterator
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 6:20=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> +
> +static void bpf_iter_mmput(struct mm_struct *mm)
> +{
> +       if (!in_nmi()) {

We discussed the same thing earlier during timer series.
Are you sure there is no way to reenter into __queue_work()?
hint.. hint..

> +               mmput_async(mm);
