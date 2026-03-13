Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1429B3BB40;
	Fri, 13 Mar 2026 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407855; cv=none; b=BoXgc96uu1P8PkbmXlZAFGQwt4vZUmNBhCJxz6UfTlygo8f83mP09LlnhIyyK3eHvNeJFXx5yi2vFVGryGqjnjJInm2KW47mpyoOLDR+dSW/Wi7WjbrE1TrfiYJIl05J5NKJsdVgoaABgHuA7MhmUg5ECzjJLYJcL74Xo3c7Htg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407855; c=relaxed/simple;
	bh=PTIXyQyDlwPJ3Xof3a3BmfGAp+M4OPOQDCa2TTf6ZqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvwdKqC/5Sz1CzCNDxucfcqGXYOFnqPfRiPyOpMWJ9xI4d0rs9GergDdS97ZBMKHg5lF7Nx0qyAxj7GODfDgZCY7IT3+tKLzXL4KVZhyJCK+EieC2nbftFAoTbjvSSlmNvAr0L7qhtXDOKwSadd3GYDA568tUKXM8eIaf77Ryo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=Ij5fSZTR; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="Ij5fSZTR"
Received: from x1 (198.223.13.160.dy.iij4u.or.jp [160.13.223.198])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62DDGPtG073732
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Mar 2026 22:16:25 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=PTIXyQyDlwPJ3Xof3a3BmfGAp+M4OPOQDCa2TTf6ZqQ=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1773407785; v=1;
        b=Ij5fSZTRwLdzKF+NYeq9AGJZ93CQ7ZOCv8TrzhFVoqk3XUSd6fsusio7SjKHXVSa
         9/KU0soicUNVKtfF2R5e14hUXi54a7wStpQWP59JnYVpEgAE1y7u/SxSLWjMP0X5
         FM7k1upwn+1i7QgP/Dd7IIztfvsli21AR5blMvLYawRNIbuxMchdG97rJWMlBnZm
         1QYjuoEJ55xp4VBKZm9rEQPjwmljb+xCi2+OtGWzdlWc2MHjuHU6dHrxUnkMAtp7
         gOd51uchJIuJ70WdwpkqNISN+HTLGzNhp9rN5/70TVO6wGpjDNlsYRHka0/3NYBs
         efy6GBIGqipxsOlh73/ZSA==
From: Kohei Enju <kohei@enjuk.jp>
To: technoboy85@gmail.com
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        edumazet@google.com, hawk@kernel.org, john.fastabend@gmail.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net-next v2 0/2] e1000e: add XDP support
Date: Fri, 13 Mar 2026 22:16:24 +0900
Message-ID: <20260313131624.6562-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312183817.104878-1-teknoraver@meta.com>
References: <20260312183817.104878-1-teknoraver@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 12 Mar 2026 19:38:15 +0100, Matteo Croce wrote:
> Add XDP support to e1000e driver. First patch adds basic XDP support,
> while the second one adds support for AF_XDP.
> Tested on an Intel 82574L Gigabit card.

I'd Cc intel-wired-lan@lists.osuosl.org since this series is about e1000e.
Is there any reason not to Cc the list?
