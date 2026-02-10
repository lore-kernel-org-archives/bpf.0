Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D11A1946BC;
	Tue, 10 Feb 2026 05:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770700838; cv=none; b=lB1m8UCguE2IFmHLxLGIEkHv0MzZWUNXqDYoifcSsWERdPOByxVgIJmtLOyxlRFFPfx0Dei41TVvoWwqBQRO3ttgVFGL2bY1cw8mhcTwxSi00eYhoNX2beYdTE5NgkPlNmGspJ31nTUaIq9d9iad8hezED10toqFfVPa2ep6yHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770700838; c=relaxed/simple;
	bh=j6m+QaLyoFfdem09Nnk7STgk0ODlJPaEKwgQiyH2Paw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDUzWmvhA40a7FwEI7Liwlq0RZti8G4Lr8cldI3zvU7vWZbpEIeA1g30beF3qTGkLCZWyirC4GzZkmkKmlfNtfXl2pQjqheeDrqvupAQFGjUBt0znGiaI+dCQapfo8Ol3jVshKc9yOjjwoRPFxUFupjbHXsBiBkIschrZN6NI5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w+MgGOcf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w+MgGOcf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471BBC116C6;
	Tue, 10 Feb 2026 05:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770700837;
	bh=j6m+QaLyoFfdem09Nnk7STgk0ODlJPaEKwgQiyH2Paw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w+MgGOcfl8CJJQTgJN0zR8wMpZ5lgV8ZWlk5Y9JI59jZ8w/QszoW0mPaoxwiEFxJm
	 4LmDcTTevfVgAFYP3TyfLnct68nwlVWJy+hl7CG3QtNo0ASUV/t7gcT/0Dr3XS+tgu
	 J9ZjZ1U3M8BAfXdRoRbgm47REledk8n/CrFFY16k=
Date: Tue, 10 Feb 2026 06:20:34 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH v1 1/4] ml-lib: Introduce Machine Learning (ML)
 library declarations
Message-ID: <2026021005-tacky-pentagon-aab1@gregkh>
References: <20260206191136.2609767-1-slava@dubeyko.com>
 <20260206191136.2609767-2-slava@dubeyko.com>
 <2026020756-remarry-declared-9187@gregkh>
 <46449ed46d60767bd13b980e5ab63faf4364f718.camel@ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46449ed46d60767bd13b980e5ab63faf4364f718.camel@ibm.com>

On Mon, Feb 09, 2026 at 08:48:17PM +0000, Viacheslav Dubeyko wrote:
> On Sat, 2026-02-07 at 16:52 +0100, Greg KH wrote:
> > On Fri, Feb 06, 2026 at 11:11:33AM -0800, Viacheslav Dubeyko wrote:
> > > + * @kobj: /sys/<subsystem>/<ml_model>/ ML model object
> > > + * @kobj_unregister: completion state for <ml_model> kernel object
> > > + */
> > > +struct ml_lib_model {
> > > +	atomic_t mode;
> > > +	atomic_t state;
> > > +	const char *subsystem_name;
> > > +	const char *model_name;
> > > +
> > > +	struct ml_lib_subsystem *parent;
> > > +
> > > +	spinlock_t parent_state_lock;
> > > +	struct ml_lib_subsystem_state * __rcu parent_state;
> > > +
> > > +	spinlock_t options_lock;
> > > +	struct ml_lib_model_options * __rcu options;
> > > +
> > > +	spinlock_t dataset_lock;
> > > +	struct ml_lib_dataset * __rcu dataset;
> > > +
> > > +	struct ml_lib_model_operations *model_ops;
> > > +	struct ml_lib_subsystem_state_operations *system_state_ops;
> > > +	struct ml_lib_dataset_operations *dataset_ops;
> > > +	struct ml_lib_request_config_operations *request_config_ops;
> > > +
> > > +	/* /sys/<subsystem>/<ml_model>/ */
> > > +	struct kobject kobj;
> > > +	struct completion kobj_unregister;
> > > +};
> > 
> > Do NOT abuse sysfs for something like this.  Please make your own
> > filesystem or char device or something else, but this is not what sysfs
> > is for at all, sorry.
> > 
> 
> Currently, sysfs entry is used for sending commands (start, stop,
> prepare_dataset, discard_dataset) from user-space on the kernel-space side. And
> the intention of using sysfs entries is the export information about kernel
> subsystem and exchanging by commands and notifications between user-space and
> kernel-space sides. Do you mean that it is wrong using of sysfs? Have I
> misunderstood your point?

Yes, this is NOT the correct use of sysfs, do NOT use it for an api like
this at all.  Use the correct ones instead.

thanks,

greg k-h
