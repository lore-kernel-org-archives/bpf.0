Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C133D75A9;
	Fri, 24 Jul 2026 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784931211; cv=none; b=PGQecABkFLACVS7sVEokQ3zH8m+YwcqeH0fBY9q7DUv7JsEJGrhgTCSuNrHoQWiM6n1t3ZHykAgUXGKBPN9K1sUaxqlNuxuNyxXyCUj3dQQoynaR6yzrgE1Zz3i9gHjxY7DgQZdx0pB+w7h/BqtFu8CqoHWHen3m1KQCpjctc+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784931211; c=relaxed/simple;
	bh=FsPNvnckssCcmzpXGj2pwET4VXHvX9EMvTQXN2iYUW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0J5TUDGDURO/hJDiJVrhrzKKxPyucIzs4IuGFuInTxtynqDeB7BLwYnpq5y8hfCd9xK7cQDy3K/wsgqp9ty2PjQHMv8P75J54QqYO8xIrhOxaeEp2Y1exAJ6D9JGug1oPIJoXbRE3tSDJiKFqiubumoIjnuxT1RFvG9Hn95B4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGBzh2cP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGBzh2cP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A881F000E9;
	Fri, 24 Jul 2026 22:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784931210;
	bh=n/zL5C8BV8AGedxFTrvc6BjmVfgU78WblF2UZmxRpzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eGBzh2cPqb6m0ymWbAWSx3nEhWJC0UEkaAQylszNGaOtYmlq+eLyoIxV4HW86Mn/W
	 E/kLEUe8Jja8U1s1gihobAEVE/PtGGvJvsgF9d0dmN+4zes5QeEmUuTYxvVZDX/aMp
	 feevGhDXuyRqctDiQeyrDygaxS+j0Qoh6/IYZNnClXAFJS/obQzG59ja8zqGjs1rHc
	 6eUkaLDtj5B5KcQ8sp0FqkCGKTMcZDMWFHXxbfjpWc/dckB9yIPmoJi4KgfSZqm+FV
	 /W5Vl/6ojD1bPhkuzk3wiqvFv0d6mg1e9AvO8578B9umF0jGwOh4n8u1Jdxug8Gldz
	 to5U6FSqe5V6w==
Date: Fri, 24 Jul 2026 15:13:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, pabeni@redhat.com, horms@kernel.org,
 bjorn@kernel.org, kerneljasonxing@gmail.com
Subject: Re: [PATCH v4 net 0/6] xsk: fix AF_XDP multi-buffer Tx descriptor
 reclaim
Message-ID: <20260724151329.5be671ff@kernel.org>
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
> This is a follow-up to Jason's changes [0] which were addressing generic
> xmit only and this set allows me to pass full xskxceiver test suite run
> against ice driver.

IIUC / I hope that there's a rewrite of this code coming up 
for net-next?
