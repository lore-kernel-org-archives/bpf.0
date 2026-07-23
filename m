Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E12833ADA9;
	Thu, 23 Jul 2026 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824309; cv=none; b=CIa5fXaA4Hg6o7xqUHPlayq7Bbwg/MWYyAUealPdbbYOY/GP5wj1S3Lf8mV28Z1E8pjjkueej8xk3Xi+VHl7+ROKAPnIqkn8wSDMBDWUA5bWtZ5VcLpytMWPZQSYYsbturHgCsUPhMGc66rsjpW9Z7VqO35nY1Aw8unL7GAaSZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824309; c=relaxed/simple;
	bh=cr6/yDwOR4iFo3665xb/EADmkfR+IublFzmY22pPca8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tr/pkxZp/FD19RQxhu6QDxLwAJY5Ke8T2p2ouXu0kFptgzx4/5zymxpV38R7/1QGhzSvea+DhBlkCUTSJP4o5cvcAuwdzCE5cczLwTkRNHg32e3UWEgeClDDHgdDDeNkU2iSa9jdX3aYfjz4qz/U18WkoR7kaGsusb/gvmdBJhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4K/UDdD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4K/UDdD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802DE1F000E9;
	Thu, 23 Jul 2026 16:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784824307;
	bh=cr6/yDwOR4iFo3665xb/EADmkfR+IublFzmY22pPca8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h4K/UDdD4D4Be+RdbJhLdWTAylziyq7GjAXcTNnAqb/rHbKy55ZDqzwuUHJ3kInX3
	 ICq/SZdeUxysGWf4Ms16Gl58OgrIk+1m3bGEkfOZUYG6kf3g078cDk+OeyoHLO6y8Q
	 1VE5koJ8lgj0BqDx4MXyxjt6F22m62duZCRLOVJE10WnqaFrZ9RjAhZaraqEOuJKqo
	 ChlwjrFVQVN5YM/2+IjlKxbTBmhsz3gQJcL6vsftDdJp00/kh2Q57Chr99N5I5F1n+
	 uKRNpaphBxHdTvy796C97IMBX2BCIWNXqldT0j9Lyn4Vqjg5t/ILtciiVpbrGG11ue
	 elEkAkO5QsT/A==
Date: Thu, 23 Jul 2026 09:31:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, pabeni@redhat.com, horms@kernel.org,
 bjorn@kernel.org, kerneljasonxing@gmail.com
Subject: Re: [PATCH v4 net 0/6] xsk: fix AF_XDP multi-buffer Tx descriptor
 reclaim
Message-ID: <20260723093137.34241470@kernel.org>
In-Reply-To: <20260719135609.147823-1-maciej.fijalkowski@intel.com>
References: <20260719135609.147823-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Jul 2026 15:56:03 +0200 Maciej Fijalkowski wrote:
> Subject: [PATCH v4 net 0/6] xsk: fix AF_XDP multi-buffer Tx descriptor reclaim

Looks like Clashiko found things Sashiko didn't.
LMK if these are real, please, I'll look at one of the other 400
patches still in the queue ;)
