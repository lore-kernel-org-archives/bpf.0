Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74D11C861D;
	Thu, 25 Jun 2026 02:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782354808; cv=none; b=ebv2HHnuVnFcE74Phas8ZNm+jFEuM+1AzC9K6JCWYu55BzdN3AeJd/4lAYwlZO1UBAg7QAEjBJO+u+axRH/yzkuEQS9O7BZ+PHGvwgniWK3CM/Mo1AsD9luv+yMbTnKaswySQxKyeBPVsH3pflFMQbOVt44abLpRvRcfHvYeXTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782354808; c=relaxed/simple;
	bh=WKlTbfrUNwUFyGpobav8CApD6v5B/qIAYIViXKGD7u8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMVsSB+1a2bJzzZjQHBSWGNxSakGO3JTD7xuwG/e/2zKR2qKluDKK7PWWGBXN8uOTd3b1b5JNOio0fbqGkatPePB92tWLJPPMMOTPw+EPwz2/OBzAoSB1Agkd+y1RIblXej7py63/ZcWUAEYpMYxvK0Vi/mIzayL31M7thuUYzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYQocmNE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYQocmNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303D71F000E9;
	Thu, 25 Jun 2026 02:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782354807;
	bh=gAp5DqBsrf+qqTJrCHBvd6moSshxYS3r3vVwtm7UlQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iYQocmNEMzyuFLh2RGCIPVlHqIqg1hTe+T8GaNwVV15IZwsj/PUgyaDpScjdfAwN9
	 SuX2DwknSxTky/q3WUUiu9hPz7r9cSEC603Dz4r/ZPi9SyEwz5NA86awUWno0Pm8+6
	 Jl5O/7nTg+qGtHq36kw8JUSNza+Neer8xIJQKZLpkb3aK0PA7tyW3tRyYcWolqcGiQ
	 27aqd75O4senmoIaBXjd39TkFvNf37NHZtmWFkruUOt18UD/vLJKnsvl8SsfTGJce8
	 1g/tTQs0tefhfnKwa+TOz/BIKI+CiNImeywAHhUEoOXmCgicsK5r/JS+gmjVQEwq6I
	 LpFZ27jiS/JRQ==
Date: Wed, 24 Jun 2026 19:33:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, pabeni@redhat.com, horms@kernel.org,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com
Subject: Re: [PATCH net-next] selftests/xsk: preserve UMEM view in bidi test
Message-ID: <20260624193326.295e3711@kernel.org>
In-Reply-To: <20260623091008.1046547-1-maciej.fijalkowski@intel.com>
References: <20260623091008.1046547-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 11:10:08 +0200 Maciej Fijalkowski wrote:
> Subject: [PATCH net-next] selftests/xsk: preserve UMEM view in bidi test

Do you want it in net? Either way - we'll need a rebase

> Signed-off-by: Maciej Fijalkowski maciej.fijalkowski@intel.com

missing <> around the email 
