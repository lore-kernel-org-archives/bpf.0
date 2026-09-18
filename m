Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF143A3822;
	Fri, 18 Sep 2026 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723212; cv=none; b=UoiCzCMVzYqgBLZ832CtpPDSR0gPqFF3UA2y9bITBxKmHD94iRoVk49zs/RoTOLPgDET3j+hKSzY/+k/KWfsMn5IUAdQsU5V+BbKOwIwF24sJVsG5JcDhkclq8je1tWwrs939El0zsUsV1FUxW3d5QahyT1KPueoypbp83tBDXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723212; c=relaxed/simple;
	bh=IupCRxNYnQ07rFqb9hyW1BDV5Tr4HCbcp/WYfHOr65o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E3e0CuxRlr/wbdsq1ZIXOAtZNwUagQGU74rMR9VUdwdumSPXUyLT3TCrt5Xzrui0F5FX5PzR793Qtn7b0dqbrNGsrTPqa2c61/zGeJiScdw9S6APGd+W/8ba0k0IezAxc+KG4vwr8MRwLaSq3fPYI26MKXcgjdxaJuZ7LvV47TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQJ/ZmZk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQJ/ZmZk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8801F000FF;
	Fri, 18 Sep 2026 09:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789723210;
	bh=qcjMRQxp+/sMO1VfRzkV7AtKn8HnHm257Vdf/wTuJpc=;
	h=From:Subject:Date:To:Cc;
	b=HQJ/ZmZk5Y7hsLMb5Aa2CErWCujQt969MoiusSghROOLQ26sFezd/Eo99+mzRgIxw
	 WdHJEfikNfs4FtRecqgX/bDcs7QsxoIApH9mTIKHoFC8OnKpR/UJiooqU0slNgJQVj
	 bwpWf+Zv44YHM0Qp9lZRtF2ivsPrSLMXkg9Nl0njJOWbRKF7O1mVi0DNXEC9EUU6FD
	 elApxctaET3HUEk9p9pV726SKDgpv6+A7YOMo/uZbmxbLaDDLEESNHh1lkEYaocnd0
	 vmYxgQP9ceExIsDJku4sfIMB2b9wU1yRzpThLtmPsmkk6N000lfgXsD7xuHsflddku
	 5sf5X8/xd7+tQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] binfmt: fixes for kres reports
Date: Fri, 18 Sep 2026 11:19:58 +0200
Message-Id: <20260918-work-binfmt_misc-fixes-v1-0-647b24bc1c46@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02M3Q6CMAxGX4X02i6wGARfxRizn06qYZgVfxLCu
 7vhjZen/c5ZQCgxCRyrBRK9WHiKGZpdBW4w8UrIPjPoWrd133T4ntIdLccwzpeRxWHgDwn2nds
 Har3VBw9ZfiTaHtk9nX8sT3sjN5daWVgjhDaZ6IZyKl3111WbrsoK1vULvNoxiKgAAAA=
X-Change-ID: 20260918-work-binfmt_misc-fixes-98c4fe6db27d
To: Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=622; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IupCRxNYnQ07rFqb9hyW1BDV5Tr4HCbcp/WYfHOr65o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWStZXKL/u1g9otpw5ml70tfqb7OffbuRWeo17fzR4+de
 zd1xr85Zh2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATWbOLkeHxpuUbTwkd69hy
 lnNHHtPpVxeZF7EdEi5+9/jWdBau3Uv3M/wVKV9/jW3XzxZrlbt366ZJ8J9+v82iuURL2vjs6aT
 +PzUcAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

I asked Chris to run his kres tooling on the binfmt with bpf changes
merged for this cycle. It found two issues that are fixed in this
series. I reproduced both of them.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Chris Mason (2):
      binfmt_misc: fix OOB read in bpf_binprm_select_interp()
      binfmt_misc: fix racy checks in bpf set_interp kfuncs

 fs/binfmt_misc_bpf.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)
---
base-commit: 5179241521401ef364294128bb43cdbce7252457
change-id: 20260918-work-binfmt_misc-fixes-98c4fe6db27d

