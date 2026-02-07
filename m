Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668E42F3C37;
	Sat,  7 Feb 2026 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770479563; cv=none; b=ScTiSRzABYVpZTfhyOLwOOna7Cm3kaop++H/Iv6/pL/uxHJtMwMJF4RHq+oAZ8DF+TfrJmpMrZvx+TUflq1yzsQYt5mJoOgbZKFAIXOFj7iCa6dWX8xJa9K+CG5CNkdbw9uRY+rVs+R5sQ54z4p2AM6Ren7HfRCj9x5JAGG+nCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770479563; c=relaxed/simple;
	bh=3caPt/SFdYRNTEo+dzqjdrsO13S53h4yikkUh2Rehmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRgP24Oj3dMCX++6DyE2+mA7HJTH/gzRL8Sh0pqsLuHXLVmGTE4/oKgXgqkwInXjKbF0KHDVxdyqWkMpruxBhhWRB6YDt4Fa1ygnuZDvM5a+UHi+7rSLWwZbD3zGs0Q4zU6plXYX0+2+dl6Fb3TxwJS6vRYCVuWHQ8GF4U53PdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xM1CQ1rN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xM1CQ1rN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C912C116D0;
	Sat,  7 Feb 2026 15:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770479563;
	bh=3caPt/SFdYRNTEo+dzqjdrsO13S53h4yikkUh2Rehmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xM1CQ1rN5w+BCMNjOxhWt/xsRibe+1dr4kkrdTVWsqr3kymC2TxGJ9jXMjpd3nwVw
	 fcJ9ijERW5U0GBg6rjXZYP8lYikC6eAVig0J6HiUuavTx1SvqOi2tecEPAQJkOGaoE
	 rW0hm4ANXI3jYvp3ptUC5jtIjD/cUEeX5hb3Bl0E=
Date: Sat, 7 Feb 2026 16:52:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
	Slava.Dubeyko@ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/4] ml-lib: Introduce Machine Learning (ML)
 library declarations
Message-ID: <2026020756-remarry-declared-9187@gregkh>
References: <20260206191136.2609767-1-slava@dubeyko.com>
 <20260206191136.2609767-2-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206191136.2609767-2-slava@dubeyko.com>

On Fri, Feb 06, 2026 at 11:11:33AM -0800, Viacheslav Dubeyko wrote:
> + * @kobj: /sys/<subsystem>/<ml_model>/ ML model object
> + * @kobj_unregister: completion state for <ml_model> kernel object
> + */
> +struct ml_lib_model {
> +	atomic_t mode;
> +	atomic_t state;
> +	const char *subsystem_name;
> +	const char *model_name;
> +
> +	struct ml_lib_subsystem *parent;
> +
> +	spinlock_t parent_state_lock;
> +	struct ml_lib_subsystem_state * __rcu parent_state;
> +
> +	spinlock_t options_lock;
> +	struct ml_lib_model_options * __rcu options;
> +
> +	spinlock_t dataset_lock;
> +	struct ml_lib_dataset * __rcu dataset;
> +
> +	struct ml_lib_model_operations *model_ops;
> +	struct ml_lib_subsystem_state_operations *system_state_ops;
> +	struct ml_lib_dataset_operations *dataset_ops;
> +	struct ml_lib_request_config_operations *request_config_ops;
> +
> +	/* /sys/<subsystem>/<ml_model>/ */
> +	struct kobject kobj;
> +	struct completion kobj_unregister;
> +};

Do NOT abuse sysfs for something like this.  Please make your own
filesystem or char device or something else, but this is not what sysfs
is for at all, sorry.

greg k-h
