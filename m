Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872C42857F0;
	Sun,  8 Feb 2026 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770563159; cv=none; b=snbImn9IY62fru6M2U7m9W7VTa32DZa7rBTpYyhRDCqo55NFs+AtF6gxV2/z9rFDxci3urSryX6Z+d7xpywY0aektxLlvc3tCrxAmeiTcrMJ8fXIc0qKeH8w7g/3Kc8FPEvQu4j4/SG1iXaHWP+J1LfDs9/30nJF3EZegGajJ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770563159; c=relaxed/simple;
	bh=6sSoqCYLXl0TAXy1yyTp7qeAwRWGdv8lliRnyEQ6jcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSoejPXQVfE9gtWta6mowBTJrCuCQbSF9078K1BoY+dUbMMwZwKl6hYq7i1zf+Ylx2BJEOFXdevBlmzqp0NVRkQnKBwLsxBmBA9X0jmkomAzOvxMfze+UcAHC9WLK4UAyw7FYlyaPzJ+3NAsqdJMbZ3l9hjN22xUae8uacp7cNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WkNAkVf2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WkNAkVf2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEF3C4CEF7;
	Sun,  8 Feb 2026 15:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770563159;
	bh=6sSoqCYLXl0TAXy1yyTp7qeAwRWGdv8lliRnyEQ6jcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WkNAkVf28h1ons5NPUPwLkqXBG7waF3gI7hnk13jeRj625I0TYuZ8vEZ0W32Pr47U
	 rZL1LFBgGohZgR6ySGsIEmI04efEqNZtet3CvZesRPnBhO4eDSZP+27cGZX0gDkAgr
	 4JKkV+jFSfo4Ih6i5fC+kXo5yCzb/Sw6wu1hBAWk=
Date: Sun, 8 Feb 2026 16:05:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Cc: stable@vger.kernel.org, j.vosburgh@gmail.com, vfalico@gmail.com,
	andy@greyhouse.net, davem@davemloft.net, kuba@kernel.org,
	kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, borisp@nvidia.com,
	aviadye@nvidia.com, john.fastabend@gmail.com, daniel@iogearbox.net,
	ast@kernel.org, andrii@kernel.org, kafai@fb.com,
	songliubraving@fb.com, yhs@fb.com, kpsingh@kernel.org,
	carlos.soto@broadcom.com, simon.horman@corigine.com,
	luca.czesla@mail.schwarzv, felix.huettner@mail.schwarz,
	ilyal@mellanox.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com, yin.ding@broadcom.com,
	tapas.kundu@broadcom.com, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH v2 3/5] net/bonding: Implement ndo_sk_get_lower_dev
Message-ID: <2026020827-rebuttal-refusal-914c@gregkh>
References: <20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com>
 <20260119092602.1414468-4-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119092602.1414468-4-keerthana.kalyanasundaram@broadcom.com>

On Mon, Jan 19, 2026 at 09:26:00AM +0000, Keerthana K wrote:
> From: Tariq Toukan <tariqt@nvidia.com>
> 
> [ Upstream commit 719a402cf60311b1cdff3f6320abaecdcc5e46b7 ]

This commit id does not match this patch at all.

Please fix this up and test the series properly and resend it if you
wish to have it applied.

thanks,

greg k-h
