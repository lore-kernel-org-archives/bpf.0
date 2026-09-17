Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1556939CD0B
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789614695; cv=none; b=Bk9yYq53c6gQWUuHS1hL+0sZMC+khilME7vj/NcbNgPor0X1NzTTkXP/Mezqyj89/z4w3O6K0wCokJK0nNM9gwN/QrkZQdSDI+WMbyUzax2JKSeiIggjgGtOEGjHTGWpQyFsmhs1JZmq7fpvSkrlgzRXwMe3OJvfTkFPTmX4hsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789614695; c=relaxed/simple;
	bh=oubV8kUjlWyQt+qzu0AyX7yPbC0jwTfEO/ZdVE1xXAk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=iY99htNm7oBwJtNNkKiJOFp97EmEOs2KVA7ZAr3m594XzDx9vSjxfP3IDwIoPDNX6yKvzZLpsnS2dY5OiqaQj2Isj2bnXmDMvjDvHCes0lKESfAILjvCXLvaMh+qEHV1wAa0ImD7vE/m/jlcW0P1aE/Lk3DJufkM72SMWAKMWB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0+lEvLw; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0+lEvLw"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1ceb47d53so45769a12.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 20:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789614692; x=1790219492; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oubV8kUjlWyQt+qzu0AyX7yPbC0jwTfEO/ZdVE1xXAk=;
        b=Z0+lEvLw+qzY2WQX2hpX6lDbwmUZM9qoyNK06wPD/JISQz49k5AmK9ZZWzayjbIvoC
         627dzkxkhAW8pPw9NxNbcqdiRlhUbC/UMdCPGFhTf6lYaJrJl3cR576Vg+8SnPJ6RWfO
         24/mO0NktV3DuauwZUNof2ojWjxqGBensmKoHY4keiHd6rliT0dGE98G/ynggJxpuj2q
         P9kGCIY1kL8eWeOroF75cNEYdLELkg6Wz0544UKOkIPyJkHQAfIYaFktSG32f12CMiI2
         INAyuVbdxUKTkfuHadTVrWhrn+CjXnNmHBR59lLy3eEAOHXhNzOuqyY2It2cvTaGUPi1
         RLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789614692; x=1790219492;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oubV8kUjlWyQt+qzu0AyX7yPbC0jwTfEO/ZdVE1xXAk=;
        b=RtBOh246Bgzpf+ZsgZPwAgXhj8EfPKr8vpqDN0MwRcwQSWE0ChPMLHPIIM5nH75bvw
         kGmHTKpyVRIc1izlbIVBY9nal9DOj0WIkIqc8RyYSWOsaUHrAxfBN79KUg91wtFSks/l
         2GKjxCvcAWjnnppWvu4jcIa7gB4tfDLQ9F8yRUgNRTxQOPPE75e+dyVpuPa/whEg5ai4
         7PUZK+xdOKICoq0Q3E6A4jjWCP4qQXnvu6qij7SyTjh164VHHps70a/JsM4oUzjvbK82
         +7v8GFFMrwobZG2B+gOnqqZsnKeY+7XvmetAGTSf4YXA++J7xCJTurADyQ4qEdpWhL0q
         tvUA==
X-Forwarded-Encrypted: i=1; AKwUvBzMAMo2butFM/vN9i7VnIJjwoqsx7/qGeVRxQRfd84i/Iax3Pnjrf2ifsFkvq7MoC5So7A=@vger.kernel.org
X-Gm-Message-State: AFuF++k4z+PC+pce5ZbpFNXYjjHuze/b+8qx8F+QKRa2D9yn/JwCphdJ
	fY82eiN/N+86MKytpQzUhUtbGREafgJ71riDdU8MlfK+gIG9JdypMkvR
X-Gm-Gg: AYBFou2S0flcXELGyYtS8s5/A1fo4sH82opEKf5ozwYQcmxjVQYZ79E32isVXOLScX0
	MyHiEFiBsx7DA2JROtAyinsSlmPOqKd6vCaiuXOptS/26Bzh9x8p0byRKhhH7hNqRAoQXgPQ5KL
	/KLP352SYwdZx5BI8/AK7IvZnEzgvjXiVmyXciBA1nWoRobccqr62RtLZED5TxS+ZrXSOKKtWAG
	1fWbKyaQu/E0zVw/k9kIqrCuH354ric5hPrfAsLsw1znPM+xMmeNIoIcpC1ty+cNmRu+RWZfkGX
	LcEn3Rkfcy/zpGM5ZVCGnqU7ivHgCcmNHQPlP454BwWvRVp/+kJvndLZTIvCjFn4HcDGYCA3zED
	f6RuUIpk76v2uurzRQLzn965R4kZZU6HEz7HJH8GOxXdqjZ99SKV442ZMDQk9dLMWvM1HhvpEM4
	WwnQxtXBb5zHwd9+A8KRSvQSey5exyS8K/d3hpThx5KcxTY9wkgD23/hnmlM+jX8Mc3mhUKd2wI
	DBz9lrXzi6WMLIFNku5MwaD0tk4rQlR8WUI4z+fOTOHlEp3WI4py08iDFwirPJVeau5YWHSOMmd
	xyRhQLlOW7L/Bl8=
X-Received: by 2002:a17:90b:4a8c:b0:39e:3d38:7ef1 with SMTP id 98e67ed59e1d1-39e3d388175mr866240a91.10.1789614692232;
        Wed, 16 Sep 2026 20:11:32 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e3abada87sm1354793a91.14.2026.09.16.20.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 20:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 03:11:30 +0000
Message-Id: <DLH9GNAO4JH7.Q7DM1I60M8TP@gmail.com>
To: "Nicholas Dudar" <main.kalliope@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <akpm@linux-foundation.org>
Cc: <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <davem@davemloft.net>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <deller@gmx.de>
Subject: Re: [PATCH bpf] bpf: Fix page double free in test_bpf skb setup
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.17.0
References: <20260917023834.2760055-1-main.kalliope@gmail.com>
In-Reply-To: <20260917023834.2760055-1-main.kalliope@gmail.com>

On Thu Sep 17, 2026 at 2:38 AM UTC, Nicholas Dudar wrote:
> build_test_skb() transfers page ownership to an skb with
> skb_add_rx_frag(). If either allocation in the second loop iteration fail=
s,
> kfree_skb() releases page[0], but the error path then falls through and
> frees page[0] again.
>
> Return after freeing skb[0], since page[0] is already owned by the skb at
> that point; the raw page cleanup is only correct for the first iteration.
>
> Fixes: 76db8087c4c9 ("net: bpf: add a test for skb_segment in test_bpf mo=
dule")
> Assisted-by: Codex:gpt-6-astra
> Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
> ---
> Please queue this fix for stable. The double-free has been present since
> v4.17 and is reachable when the test_bpf skb test encounters an allocatio=
n
> failure.

No.
I don't think you have a way to reproduce it.
We don't scream "bug... apply to stable" just because AI found a tiny
race.

pw-bot: cr

