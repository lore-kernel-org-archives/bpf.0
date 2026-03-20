Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8465727B32C
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 02:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773974492; cv=none; b=ByrNm2ynV9O5wuNtpPjdoaz8gzQVx08LSyHTilAlG+Yhr11NMvMZgdn601BXqwbVmiXIimWWLbHBOvMw9izGnvs3UmCjuj5Pd9OGzsRC2FY1PEafVLIeKxz0a459fdUUaqxxM9xS1n8IwRoce2rhMPpLm+tu3cHQhASd7cky45M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773974492; c=relaxed/simple;
	bh=gx39cXvKf6XMjyeYPfkYwFWnZEfzQCZYY5Fl2/L3sR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eFFNlAcf6pzQg4VEw+0xSQNkXL1r41E1Op36d1nUvcvUDlvpT2u3j/Dy8vfv5dqV7LBrwV8zjJQb6QmcozxgNygmYzMVIZfvRbOwcEwi9ePIwtkf/wAnG8qFtfctlC7bYEx8noF9/kuP4JQNQcxX2zukxLGPU0FFjl6BfEZsyfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0pXYUYZ; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0pXYUYZ"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso1013505e9.1
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 19:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773974490; x=1774579290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hA380pCFY/heFJYh+oChUrDKsjPjqMAgTd7ssSWj/lA=;
        b=B0pXYUYZHn2lpMNyMxrr98KJgzTLZ1lrdrurpNXLcDpA61uOScy5TbfFlwAq7cEmtG
         3NrASE/i1i2VATLZN5Tw/aAcnVUxwVtasg3PNKHGgllDacoEwiSMGabsypcMjbuIAFoM
         vXw4WB+7TFjMZZ9JAwvvNrNO7Lnq/Vo/YSijzoNfg2zwm6RDVrWbLs0w7kyGy02G2wUl
         vfH2f1yiEYlTVyuXxeuaYd5o8hJ325auK3PlqZfZvKb+XeL20UuT85OX0O4S/ypAi+Uq
         ybJA0+dOzYw+Cd5hCWwZ0VEo0dPF/6EJL0DxeX1PXQ1BCWCzWgFvlBm3tTRVcT55eZ7f
         DsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773974490; x=1774579290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hA380pCFY/heFJYh+oChUrDKsjPjqMAgTd7ssSWj/lA=;
        b=k6GuN0sUlmL862zRV0vjQKi2u6PFtw6AmhD4A7ptG8J0PPcacGBbqdHUQA+FMcPbuy
         k0s+R9N/SPVn3wQdidDR0lYXWaF0Mzk+kN/0t8+TC2g02oRC9nx0mG1Fo2tWQ7k3uAUc
         uXnLnqPZNEL/FYiyBVSC7O1gENEQYzkB7wWalARFkhVt78iP8sufuuF6Ryoui+N0qaZH
         f2RHubWpoQXHeRc5I9ekAYT61xKYtcJQpSjFCuF94Sl4VMw+a0zcWagvn3hnJBCczIZ4
         jUBXkSfxmjoLeUEMuNy4b/cJoyDY/j2T6mTGCIlu56Zjwb14G7zL6DPf97fAbZmckcGo
         9X1w==
X-Gm-Message-State: AOJu0YzUguNhiHxGuXofcbDBFFh03FIWaoDJA8i+MVzV+J409eYSRdIJ
	aIOwz6LHDef3d++NdHQpqXeZVkSxfArlNu8kCOgQuK8W5S1zclvmJFP1
X-Gm-Gg: ATEYQzxAK2TBMUbbRWbV1i7CSWenRuQlZYyfgUkOIo/Md4JVy6F5eFla6JYMTCLIYgl
	6N/vN67DLwobFDl2uV/lea6wu6eztAsfNuupvYDoPWL7mJu4i6Tnw8NwITx7tOoX1e5Mr+1Rrni
	9lRMHzAxi4hlkS3b8ro/nrXyfm8gVG/UZQUTPsNS8aKUj/hXWoGiEqp4mumq3Ug0B8g99lL9sGL
	XwUKbyS9QTYKtSBDEPs66jFAWWIz/AnymUYx12/7r013TTpin9wvciFcAOscVtyflzzFfyI5lAS
	VdPs9GmszScd4N05PGrbOES7mJ3Ck3pbWdM/pKvGs09T50M28ffgV8CVo8YEbW4I0nDef2EHiNK
	aWHozUy1bfQVNveKix/AlOUUHjIii1wyd45buwK7ToIHO2FyTVtqXErFj0CVFXNPlavjeJkXmAA
	KCXFQ+EBjpu7bvcworPn0A7LvSU6Hx8dJLR1rgNSkbD6JtUwF6nA==
X-Received: by 2002:a05:600c:c111:b0:485:35ee:f836 with SMTP id 5b1f17b1804b1-486febbc310mr13756255e9.2.1773974489489;
        Thu, 19 Mar 2026 19:41:29 -0700 (PDT)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae016sm2416039f8f.4.2026.03.19.19.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 19:41:28 -0700 (PDT)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+ca51b6e7e751edd6bbfd@syzkaller.appspotmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [syzbot] [bpf?] [trace?] KASAN: slab-use-after-free Read in bpf_trace_run4 (2)
Date: Fri, 20 Mar 2026 10:41:16 +0800
Message-Id: <20260320024116.3421185-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <69bc31f8.050a0220.18f14c.0051.GAE@google.com>
References: <69bc31f8.050a0220.18f14c.0051.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a fix patch [1] for this issue, and it is the same as syz-AI's
analysis.
 [1] https://lore.kernel.org/all/20260304092345.233522-1-wangqing7171@gmail.com/T/

Some similar issues which have syz reproducer:
  https://syzkaller.appspot.com/bug?extid=9ea7c90be2b24e189592
  https://syzkaller.appspot.com/bug?extid=b4c5ad098c821bf8d8bc

Welcome to review and comment this patch.
--
Qing
