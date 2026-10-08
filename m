Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAE4448BB6;
	Thu,  8 Oct 2026 21:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791495670; cv=none; b=itOchtr3mIV7pe4tv2I/LiVl38ktGVC3N8JZQce8Py9r/eqY4Wdh8WoBuSQat2RjXG64drCPhGLq2SgilvfpenMR5wqLf4HbwrEnG5e/Nx1Q+6I+wB8YCNNdicLqZd5cXnlcx8e1TAqDfw3IbiDQDwmkHg2bKS/u1RrBmq3Rdq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791495670; c=relaxed/simple;
	bh=vyiaRk3r22Apv0KEtzqOmsDJMb6ocYPX10Nl/JCuv04=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mw55gqa498qEXcCmewMp0QIahlbxtCbL+qJcD7c419Kt7kJUFXWeFgc4F7CjqSPinkfkbVa8TJrCyo0Kz8rHlzhP44nRMLCYv5n3/bW6hNphPg6KGjM6o5PJMne8wobzTGtV/L80eHs2qjNAVHYFeguqSEZdcsljfFZtBXhV8Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOAoIVfh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOAoIVfh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38D61F000FF;
	Thu,  8 Oct 2026 21:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791495669;
	bh=/k/hxDIEN3Hzemz/rN68B4NPxOscSdDHAYKTWxfP4wE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hOAoIVfhONzzlSdYo6eezK6BHxOLm4g4o6kQI3+bgypJtgGC8eMsRQWVXv7IvOriX
	 f59J5bGf199S86c6YbPbHdbuevUJ2L+KEY1Wp33zp7aU1CRuB+T+Del2s9F+Kch5rZ
	 C7tYHurdyB8k2IcI4kW4S+m2gR1dqiy1N4AvEXkzmjE1134Eegs423CaJ5+N8ai3xi
	 sz+3MlWmU7TGmojCr7om0hUSZpftmUpFOUz0+5KF/NuAYGnZIRPLiRcY8I/ozCybyP
	 yfBHcS/rYzIzwffR77gRb+06bQZgBeWl55C/LLj0URWV/zGMAZFZeDzKVrAZ2coXlr
	 DjkvKqynvfL3g==
Date: Thu, 8 Oct 2026 14:41:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, bjorn@kernel.org
Subject: Re: [PATCH v2 net-next 14/14] selftests: xsk: document generic and
 hardware endpoint runs
Message-ID: <20261008144108.164cbc6d@kernel.org>
In-Reply-To: <20261008114909.734364-15-maciej.fijalkowski@intel.com>
References: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
	<20261008114909.734364-15-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Oct 2026 13:49:09 +0200 Maciej Fijalkowski wrote:
> Document the per-case veth launcher and the two-host hardware setup
> where the DUT uses AF_XDP zero-copy and the remote xskxceiver uses SKB
> mode.

Why all these instructions? Just make ksft run all the combinations you
care about testing, no?
