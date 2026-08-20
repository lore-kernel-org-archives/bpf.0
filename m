Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAC446F483;
	Thu, 20 Aug 2026 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787247862; cv=none; b=coQeJDPEE8TslJYxgdd6+SUswf8iPcmODTARGS9VIpYy1pHm8pu/7VvY1ZSwjFpTSkRMk5zViQaxr6WoD0MNeyL3lDKKJhplcGRQRA9IwZlJawf5HPorHGa/HoA6mQC6V4kdfWlFpJAQNjOwftwxjxTaTkAZfW0n5YjZGSz5zlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787247862; c=relaxed/simple;
	bh=ufhwFmCuxqOmcf1bKOmVJlnlz+9Jzom57md5eAPV2b4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JChtBbggoDdAdWPYVG4OvYG1cWyVFo0MZ01lFA5HwWriOyX+oLfRpxXLb+jD0MGKmQTx2csPR5pK9XINNbRGRLO/UEzdVJHpv026JK1+2M0ByYe5ZScEGcZfJen02t8xcTOjG8CEmAf/4mLhwf2SDflpTGPmko2Z18yipZOz4uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQTLjMv/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQTLjMv/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEED1F00A3D;
	Thu, 20 Aug 2026 17:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787247861;
	bh=ufhwFmCuxqOmcf1bKOmVJlnlz+9Jzom57md5eAPV2b4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IQTLjMv/O/zjtiLTDGvfB/vZSK1wkblM3aLaqbyqVfPXUL0+/z1e5Uw5YWrwwue5l
	 w+aGJtb2wupWgI6TauId91kdAPzdpR7lWwp8cUxXXJ0L4KVx9d5sQIy+hL5FngFQv5
	 Eo88+DsO68WW+hEjE2bU/O/42uoXnog47Eru4q8gpDeOcPJVjMgJWKJOdAiwPEUGas
	 SMlQD50SkVZaAPRZyjwzV+jJnAZiC0cHSUX99GsRgCLKSuO17kZS9sDWrlXiFYDmeA
	 s7hipU2wBCrC/HcPKajR+Btsrjy4MGMCIbkK4b/9jqqviYkTnIUFkAtpZcAbLh1vua
	 ProqS+n7dUZwg==
Date: Thu, 20 Aug 2026 10:44:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Tushar Vyavahare <tushar.vyavahare@intel.com>, netdev@vger.kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 stfomichev@gmail.com, kernelxing@tencent.com, davem@davemloft.net,
 ast@kernel.org, daniel@iogearbox.net, tirthendu.sarkar@intel.com,
 andrii@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/4] selftests/xsk: improve shared-UMEM
 coverage
Message-ID: <20260820104419.050cbc44@kernel.org>
In-Reply-To: <a602a1f6-e279-4c7c-86df-1bd0ef244fd0@redhat.com>
References: <20260819024443.781764-1-tushar.vyavahare@intel.com>
	<a602a1f6-e279-4c7c-86df-1bd0ef244fd0@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 11:35:53 +0200 Paolo Abeni wrote:
> ## Form letter - net-next-closed

these are bpf patches. Tushar, tools/testing/selftests/bpf is BPF
