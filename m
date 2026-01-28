Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91652275AE3
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 08:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769589950; cv=none; b=BpTNtwIue+H8xtGgZW2WJg1d9mEqDKKzQC43aVWwdKzSO0+QdrI7goeew/dNciNwaR+EAzBoE8fSXQmx5IQykeG4237vlbeb4aWufOWg1sK6yyrh2Qvuw0Btcm6wX/XGN/Rdn7NJLGM0qAJmZKuA53hGzjgat2g4ynYRvMjZanE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769589950; c=relaxed/simple;
	bh=iafuYqSmgzl67w4L8S669bTJDaKIv567Cp/r80sNvek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BnyLcA+MjtkXKxFxtis5Xzd2U1jXZaeTn2JYatCPSQyIoY5b0Tq2aiiAh8hdtdm2Er5oZZYosAYlupj0UGpbQFzcTD4n/kz0Tdt44d051mledgJ3S0YeGfkfh6qK/jOClyl5FaNBf7j2N/vIpQtIUBMxDugiFnlTW4wSfsY27xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiRed8KB; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiRed8KB"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a79998d35aso42596835ad.0
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 00:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769589949; x=1770194749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBiC0Ga9PNqkTYY+QPAQfS35mNItKw6OX3nueD/z0VI=;
        b=LiRed8KBj72URvu2BHj6236YYVF2zXyk0U7E4S1u2kM2WyRjENUHUSc4pyhPN1V4Rj
         RoMdxyGekta1RDpzd920y+wk6hsSEYhNsBOn//0kc2rnUYnTUGQUXy81N2AHjrwv40Wr
         89aLmyQy/sF4deRiXX9deQE3K395Xsg6S4ks2Qv2poRV+RG/zkUEdgg8JHB8FrtsU/b1
         RRVioM2os4bGQWDdvGbHaYWYKfZFKGewEIa9ahVpEfiUYNllW6oxLlG/QVLT5PKNoH3M
         uNdkfeyDnx5pBjrX7aD4lp+XH2nRIp/6WLF+mTa9paAmkvaSB9ALREgvyuJJG1P8GHbF
         rJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769589949; x=1770194749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FBiC0Ga9PNqkTYY+QPAQfS35mNItKw6OX3nueD/z0VI=;
        b=eSuD+Ub/osyVU87MHe+z7kaQmQTJF8/jxJD30nsaVSz2c3p6feUqikDekkIHHoaDBg
         0CcHSHZi9UM5gtbtkeafVJFXlaOoJ9uJP/s1//e7D3EguBOvrfdQB247sBZO+Xhz9ao/
         EZf5bvTGiIBJCDrnOBNMqbKA6IfrXa+SvDiDkME+Xk9CTR9t7nxVgkZTwWEdRfVhRxoE
         1YdT2S3JsDfF+zOn8CcFSVmwh1AsH+TTR3SYHo5dWV/DbgeA12qrDzXB9jDmBH01QSjW
         vbD5/tpLdC2e7gB7aMAcHbARBMrn5ISxsk5X5AeTFPbLJKTIMtRTQwFsOiIQ26Hcx2IA
         AI4A==
X-Forwarded-Encrypted: i=1; AJvYcCVjudCfKnsSFMPlY/wdM1ToWcXbvhtSxJ83CtIJOfSKrZRtLfuzIOaqrRfMhfQH6qiA8RY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6TxMz/Mvjq6hF1fzxcmzmhuE1mK2JEktmhXiNQWAS9zmGGECl
	WEDNZGjazjbJ+H9TWof3HPT4N1hO6JPNWvv8o7SWWpSglxG9ei5QATEs
X-Gm-Gg: AZuq6aLVKRNicTuRWVAgT9eYMQEAnmhCrf4A9cHGHTmoFbte5cWzaxLbkza/i458a3G
	h/1pVXRTqFHkU32u4nDsSn2s+BcnWeOesPPCQYXENYJhnjzpUh5L7jPEdhsrthMqSNTi+3Pl2ZQ
	2kX7t5H4gKgMlot+60WeifCYwr7ptQdkymzNGQFkL6RCrkgBKt0zMm40qABUs444/DdYDVUIK3N
	B/CJXlBeEXd/maHcjjmrAlL0puNyhu2onNiKNqumThPSR7mYanO35BVb7OpXuy18vYKsvBINvKH
	TA6XeakpLiJwtDfGoS4YYx+CvWf22AieyUFXE0RbtxeZMCtKKolKAkC14tuC+aCuCqCTaVbccxW
	H50/48FFs85HYxupjOsuitMWxgZsbJz6nKCkDjTMC1aD7gNg3CgRI9EDHMp+/mi2k8IwnvJYavz
	CAWTtGAVLHSERPLPDy1OZYAVMgcB3Ql60m14H9FA==
X-Received: by 2002:a17:903:1a6f:b0:2a7:5095:c92a with SMTP id d9443c01a7336-2a870dc6c2bmr50103835ad.31.1769589948880;
        Wed, 28 Jan 2026 00:45:48 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c3d4csm16177195ad.56.2026.01.28.00.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 00:45:48 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: chen.dylane@gmail.com
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	andrii.nakryiko@gmail.com,
	bpf@vger.kernel.org,
	irogers@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	radoslaw.zielonek@gmail.com,
	syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com,
	wangqing7171@gmail.com
Subject: Re: [PATCH] perf callchain: Fix suspicious RCU usage in get_callchain_entry()
Date: Wed, 28 Jan 2026 16:45:38 +0800
Message-Id: <20260128084538.1889001-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <874829ba-00b9-49cd-8f67-a4c33a8f409f@gmail.com>
References: <874829ba-00b9-49cd-8f67-a4c33a8f409f@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 28 Jan 2026 at 16:19, Tao Chen <chen.dylane@gmail.com> wrote:
> I have a change that will remove RCU. As Andrii pointed out, using 
> get_callchain_entry without RCU lock in BPF appears to be safe for now. 
> Please point out if I've missed anything.

Oh, that's a great way. Thank you for reminding me.

--
Best regards,
Qing
