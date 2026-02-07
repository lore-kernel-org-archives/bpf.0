Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F3A33554C;
	Sat,  7 Feb 2026 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770479719; cv=none; b=H/GFgUWg9by91rxqMCdYFA6uNYn15A1QybbHFhWI/5J/KIT+5wAFYJ2w2Jyy/HTbh4yCQ+qFP2wV6hD8UXUuJLJEsGYhcM8/mh6FbddqGEtrooIGAp94BauANQW8PNsd4qKDqmxa6npo+zy/e4OCFiROG3YELLSm7jRq/GaoeV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770479719; c=relaxed/simple;
	bh=u4cdu7LU2++Dj+oZF3MV9n1uNpHRItmMPalmPX9YI70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOg4bWEiBxBeG64e6wCXoAIUtfS8rNSYy2RzcnaUTJrFoSP+MKkrHd7G9Agb8YUYM7vl5TPXwyzzm05nHJLIlWIogWKinZAycT8UHF+Dwdhdz2ChHhwdawX2Gs6BbJDoPEDpQwtBRW14DLq54Rgt7EuSoMmQxxzT62svZPKUrwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=X7h1bo3L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TnKt90u3; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="X7h1bo3L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TnKt90u3"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 008AF1D00066;
	Sat,  7 Feb 2026 10:55:17 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sat, 07 Feb 2026 10:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770479717; x=1770566117; bh=RRj6BKNr/q
	9soARGeWpVLXX4DM+VgJ2PyVbqhDP5l+g=; b=X7h1bo3LcSWGun/j3/Wlcop+tn
	VE2WGpUOw949VG/sUBb+So84nSLxUIYFuB+AYwWIigeO6Q6JCu1MkP57fTeloJPY
	GDTtDfLK7n3gBcDrvIGzKQJzNaUo6FBCYU0NUsHmwuLdVakTtcH0e6dmIudQ42za
	+w3jbCvKq8zzOqTXQ2YBsaq+y8fxUajUZP7EV+TuvcoDheKyNzL9gLPE4u2V0AF9
	RPsIdb7XVIR3YjekRmGaZkKPx/sQgYs+ij6HCV5wgTOMKTwvywvUk8SO1JDjNI0g
	EvjXIk3fEg1iVlMLFzTMmGp6SWP/pzlIx4cQrBZomlOfXpgPOGPrcdL+Lgww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770479717; x=1770566117; bh=RRj6BKNr/q9soARGeWpVLXX4DM+VgJ2PyVb
	qhDP5l+g=; b=TnKt90u35ifweiw4Lani8nSB9gpYr36UYkP6Cfwgym1ZFXBZYmW
	PPiqtAhAReCWWEC4fP7JfB3/A3JYm2XS1zGX8sJtcbT2o9RUuR60Xzd5iigbHfqU
	zQvHU1k1m0ErF7qKPjhm5Fhqv2W0YJ4+CMASH2J7ndLbdKoYs7oqrSho1N2ic6jP
	Z5K/Yz5fJd3X7mqoEr2tPGSmW91hzNjN2pXfNAmT0UvX0xTkp6xHXj1X0P/CRFVO
	A2zOARRp1SlXopEtqvAkL9qrg5UdrqUMj83kEwfne+oR4G7OE/cvRw9Aiwf6+uYM
	KoZm4NodOtFozqU2YU3puZP2akWgCLhcJ/g==
X-ME-Sender: <xms:ZWCHaTkVsBzVkjbXom8JRO2RJhFfVa1aC2qSzWbzN__Uo05SAjVeYg>
    <xme:ZWCHaTiLQHYavMM4STlpwRkgSzy_riHvyLz-S6Fh14y5Fnf5ey1V-qHlPQDVTj9JT
    FkpeuRqWiWzK4roHaR8HPZyj9JuPqawOMmtv_bx8ZiseoSuOA>
X-ME-Received: <xmr:ZWCHadh5HbhpT_W2JhFlQrvz6-l1mZllvKwjMsBBZlR_IEfs4qdqm5_mKIpZCSQUd8uea8Ah-6Hc9olhoBRdEJfEibkNV2eDEhL8qQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledugeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhf
    dtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepuddvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehslhgrvhgrseguuhgsvgihkhhordgtohhm
    pdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthho
    pegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhlrghvrgdrug
    husggvhihkohesihgsmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZWCHaVvk6iA4gdRYE64I__QFvx0cFZyVefN7fhskTAyZs0B_ciNvEA>
    <xmx:ZWCHaVtKiEIw1bQi7bRiokGws6YemGOflh5cb8YvCOAFNi3AbE_yNg>
    <xmx:ZWCHaTqyOW09q8JjFEs2JmBqsnS5e7f8vZJPyoozqrfz_mvXto1WrQ>
    <xmx:ZWCHacKGkxCtH6ESXrZJhhDyC0NIFL2myp4Lis4r3wZ4PbrxrugVLw>
    <xmx:ZWCHadwD9im2-xdcMwOzx3l_2ClyqLYPNgF03DVstTE_WXOA9RsH9iAJ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Feb 2026 10:55:16 -0500 (EST)
Date: Sat, 7 Feb 2026 16:55:14 +0100
From: Greg KH <greg@kroah.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
	Slava.Dubeyko@ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 3/4] ml-lib: Implement simple testing character
 device driver
Message-ID: <2026020719-thrive-domain-f0c2@gregkh>
References: <20260206191136.2609767-1-slava@dubeyko.com>
 <20260206191136.2609767-4-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206191136.2609767-4-slava@dubeyko.com>

On Fri, Feb 06, 2026 at 11:11:35AM -0800, Viacheslav Dubeyko wrote:
> Implement simple testing character device driver
> 
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>

It's hard to tell if this is just an early april-fools joke or not, but
if it's not:

> +### Character Device Operations
> +- **Open/Close**: Device can be opened and closed multiple times
> +- **Read**: Read data from a kernel buffer
> +- **Write**: Write data to a kernel buffer (1KB capacity)
> +- **Seek**: Support for lseek() operations
> +
> +### IOCTL Commands
> +- `ML_LIB_TEST_DEV_IOCRESET`: Clear the device buffer
> +- `ML_LIB_TEST_DEV_IOCGETSIZE`: Get current data size
> +- `ML_LIB_TEST_DEV_IOCSETSIZE`: Set data size
> +
> +### Sysfs Attributes
> +Located at `/sys/class/ml_lib_test/mllibdev`:
> +- `buffer_size`: Maximum buffer capacity (read-only)
> +- `data_size`: Current amount of data in buffer (read-only)
> +- `access_count`: Number of times device has been opened (read-only)
> +- `stats`: Comprehensive statistics (opens, reads, writes)

Again, this is not an acceptable use of sysfs.

> +	/* Allocate device number */
> +	ret = alloc_chrdev_region(&dev_number, 0, 1, DEVICE_NAME);

Don't burn a cdev for this, please use the misc device api.

good luck!

greg k-h
