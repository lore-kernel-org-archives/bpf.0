Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B750A259C80
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770807840; cv=none; b=SNJ4n28cfLGa4/qarCSjUsMXPQdC6OcOs7r7JLhDVXkqX4VK+fQL3Pu1kZrTl/lBsCg1RzhjcsTW1wjABPd0t6FR/AZDerOuvUTHj/MaSNQ9g1CsYfhwrCY/pL1rHy9+Se9mdu35sbcR7/SC4oLO2B4nAe/AqzL24fH8jVx9oqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770807840; c=relaxed/simple;
	bh=GtVP6LwridvPeyYxZtWRekDNlr7MX5WqvMbXRVKDklc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERglmDm0+swUS0CMg7haUMwO29jFxzYz8FFKyVD381sPGerUIpxRgwkkQUrU91PiDg5x8myNknYtu+HA2d9OdsE73u02Yb9Xd5RnrtGnFfJfqVXnhzKLTe/LU8/bUPXjL3QfcGqSR28bncXta0CMOJI2oO4XkzWHz50xRwFXkYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfJTygEq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfJTygEq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770807837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WYrNCnZmZ5SZq9UooX/hkFOBpWsshxFW7+sqfLe4TnM=;
	b=EfJTygEqcmPz0bpwVNzIuzEprwDiqKrCkegILlzGvIzQgYJZ+BIkEaidCJq0xJSkffnaFC
	d/XMnhxEF67n7O9VHIEuluce8MBae8Q3A2g9jgfZvrwEXS9PrQY0E/mgpSv6pByL56AHpy
	tC82PisNLP5IX9xrEDVa9nPP1BXE/Io=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-FOpEAII5MeG7rxh7HDOcFA-1; Wed,
 11 Feb 2026 06:03:56 -0500
X-MC-Unique: FOpEAII5MeG7rxh7HDOcFA-1
X-Mimecast-MFC-AGG-ID: FOpEAII5MeG7rxh7HDOcFA_1770807835
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9EDB19560AD;
	Wed, 11 Feb 2026 11:03:54 +0000 (UTC)
Received: from fedora (unknown [10.22.88.75])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 64C5518003F5;
	Wed, 11 Feb 2026 11:03:49 +0000 (UTC)
Date: Wed, 11 Feb 2026 08:03:48 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Tomas Glozar <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, John Kacur <jkacur@redhat.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/4] tools/rtla: Remove unneeded nr_cpus arguments
Message-ID: <aYxh8jbeDENgZ9ht@fedora>
References: <20260209092436.2899888-1-costa.shul@redhat.com>
 <20260209092436.2899888-3-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209092436.2899888-3-costa.shul@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Feb 09, 2026 at 11:24:34AM +0200, Costa Shulyupin wrote:
> nr_cpus does not change at runtime, so passing it through function
> arguments is unnecessary.
> 
> Use the global nr_cpus instead of propagating it via parameters.

The parameter should also be removed from timerlat_bpf_get_hist_value(),
shouldn't it?

> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  tools/tracing/rtla/src/osnoise_hist.c  |  4 ++--
>  tools/tracing/rtla/src/osnoise_top.c   |  4 ++--
>  tools/tracing/rtla/src/timerlat_bpf.c  |  5 ++---
>  tools/tracing/rtla/src/timerlat_bpf.h  |  6 ++----
>  tools/tracing/rtla/src/timerlat_hist.c | 19 +++++++------------
>  tools/tracing/rtla/src/timerlat_top.c  | 19 +++++++------------
>  tools/tracing/rtla/src/timerlat_u.c    |  6 +++---
>  7 files changed, 25 insertions(+), 38 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
> index 03ebff34fff4..d83ee047a5f5 100644
> --- a/tools/tracing/rtla/src/osnoise_hist.c
> +++ b/tools/tracing/rtla/src/osnoise_hist.c
> @@ -62,7 +62,7 @@ static void osnoise_free_hist_tool(struct osnoise_tool *tool)
>   * osnoise_alloc_histogram - alloc runtime data
>   */
>  static struct osnoise_hist_data
> -*osnoise_alloc_histogram(int nr_cpus, int entries, int bucket_size)
> +*osnoise_alloc_histogram(int entries, int bucket_size)
>  {
>  	struct osnoise_hist_data *data;
>  	int cpu;
> @@ -652,7 +652,7 @@ static struct osnoise_tool
>  	if (!tool)
>  		return NULL;
>  
> -	tool->data = osnoise_alloc_histogram(nr_cpus, params->hist.entries,
> +	tool->data = osnoise_alloc_histogram(params->hist.entries,
>  					     params->hist.bucket_size);
>  	if (!tool->data)
>  		goto out_err;
> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
> index 7dcd2e318205..73b3ac0dd43b 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
> @@ -51,7 +51,7 @@ static void osnoise_free_top_tool(struct osnoise_tool *tool)
>  /*
>   * osnoise_alloc_histogram - alloc runtime data
>   */
> -static struct osnoise_top_data *osnoise_alloc_top(int nr_cpus)
> +static struct osnoise_top_data *osnoise_alloc_top(void)
>  {
>  	struct osnoise_top_data *data;
>  
> @@ -496,7 +496,7 @@ struct osnoise_tool *osnoise_init_top(struct common_params *params)
>  	if (!tool)
>  		return NULL;
>  
> -	tool->data = osnoise_alloc_top(nr_cpus);
> +	tool->data = osnoise_alloc_top();
>  	if (!tool->data) {
>  		osnoise_destroy_tool(tool);
>  		return NULL;
> diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
> index 05adf18303df..8d5c3a095e41 100644
> --- a/tools/tracing/rtla/src/timerlat_bpf.c
> +++ b/tools/tracing/rtla/src/timerlat_bpf.c
> @@ -191,13 +191,12 @@ int timerlat_bpf_get_hist_value(int key,
>  int timerlat_bpf_get_summary_value(enum summary_field key,
>  				   long long *value_irq,
>  				   long long *value_thread,
> -				   long long *value_user,
> -				   int cpus)
> +				   long long *value_user)
>  {
>  	return get_value(bpf->maps.summary_irq,
>  			 bpf->maps.summary_thread,
>  			 bpf->maps.summary_user,
> -			 key, value_irq, value_thread, value_user, cpus);
> +			 key, value_irq, value_thread, value_user, nr_cpus);
>  }
>  
>  /*
> diff --git a/tools/tracing/rtla/src/timerlat_bpf.h b/tools/tracing/rtla/src/timerlat_bpf.h
> index 169abeaf4363..f4a5476f2abb 100644
> --- a/tools/tracing/rtla/src/timerlat_bpf.h
> +++ b/tools/tracing/rtla/src/timerlat_bpf.h
> @@ -28,8 +28,7 @@ int timerlat_bpf_get_hist_value(int key,
>  int timerlat_bpf_get_summary_value(enum summary_field key,
>  				   long long *value_irq,
>  				   long long *value_thread,
> -				   long long *value_user,
> -				   int cpus);
> +				   long long *value_user);
>  int timerlat_load_bpf_action_program(const char *program_path);
>  static inline int have_libbpf_support(void) { return 1; }
>  #else
> @@ -53,8 +52,7 @@ static inline int timerlat_bpf_get_hist_value(int key,
>  static inline int timerlat_bpf_get_summary_value(enum summary_field key,
>  						 long long *value_irq,
>  						 long long *value_thread,
> -						 long long *value_user,
> -						 int cpus)
> +						 long long *value_user)
>  {
>  	return -1;
>  }
> diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
> index 841118ed84f2..dee5fbf622c3 100644
> --- a/tools/tracing/rtla/src/timerlat_hist.c
> +++ b/tools/tracing/rtla/src/timerlat_hist.c
> @@ -83,7 +83,7 @@ static void timerlat_free_histogram_tool(struct osnoise_tool *tool)
>   * timerlat_alloc_histogram - alloc runtime data
>   */
>  static struct timerlat_hist_data
> -*timerlat_alloc_histogram(int nr_cpus, int entries, int bucket_size)
> +*timerlat_alloc_histogram(int entries, int bucket_size)
>  {
>  	struct timerlat_hist_data *data;
>  	int cpu;
> @@ -223,8 +223,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
>  
>  	/* Pull summary */
>  	err = timerlat_bpf_get_summary_value(SUMMARY_COUNT,
> -					     value_irq, value_thread, value_user,
> -					     data->nr_cpus);
> +					     value_irq, value_thread, value_user);
>  	if (err)
>  		return err;
>  	for (i = 0; i < data->nr_cpus; i++) {
> @@ -234,8 +233,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
>  	}
>  
>  	err = timerlat_bpf_get_summary_value(SUMMARY_MIN,
> -					     value_irq, value_thread, value_user,
> -					     data->nr_cpus);
> +					     value_irq, value_thread, value_user);
>  	if (err)
>  		return err;
>  	for (i = 0; i < data->nr_cpus; i++) {
> @@ -245,8 +243,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
>  	}
>  
>  	err = timerlat_bpf_get_summary_value(SUMMARY_MAX,
> -					     value_irq, value_thread, value_user,
> -					     data->nr_cpus);
> +					     value_irq, value_thread, value_user);
>  	if (err)
>  		return err;
>  	for (i = 0; i < data->nr_cpus; i++) {
> @@ -256,8 +253,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
>  	}
>  
>  	err = timerlat_bpf_get_summary_value(SUMMARY_SUM,
> -					     value_irq, value_thread, value_user,
> -					     data->nr_cpus);
> +					     value_irq, value_thread, value_user);
>  	if (err)
>  		return err;
>  	for (i = 0; i < data->nr_cpus; i++) {
> @@ -267,8 +263,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
>  	}
>  
>  	err = timerlat_bpf_get_summary_value(SUMMARY_OVERFLOW,
> -					     value_irq, value_thread, value_user,
> -					     data->nr_cpus);
> +					     value_irq, value_thread, value_user);
>  	if (err)
>  		return err;
>  	for (i = 0; i < data->nr_cpus; i++) {
> @@ -1036,7 +1031,7 @@ static struct osnoise_tool
>  	if (!tool)
>  		return NULL;
>  
> -	tool->data = timerlat_alloc_histogram(nr_cpus, params->hist.entries,
> +	tool->data = timerlat_alloc_histogram(params->hist.entries,
>  					      params->hist.bucket_size);
>  	if (!tool->data)
>  		goto out_err;
> diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
> index 3e395ce4fa9f..25b4d81b4fe0 100644
> --- a/tools/tracing/rtla/src/timerlat_top.c
> +++ b/tools/tracing/rtla/src/timerlat_top.c
> @@ -62,7 +62,7 @@ static void timerlat_free_top_tool(struct osnoise_tool *tool)
>  /*
>   * timerlat_alloc_histogram - alloc runtime data
>   */
> -static struct timerlat_top_data *timerlat_alloc_top(int nr_cpus)
> +static struct timerlat_top_data *timerlat_alloc_top(void)
>  {
>  	struct timerlat_top_data *data;
>  	int cpu;
> @@ -196,8 +196,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
>  
>  	/* Pull summary */
>  	err = timerlat_bpf_get_summary_value(SUMMARY_CURRENT,
> -					     value_irq, value_thread, value_user,
> -					     data->nr_cpus);
> +					     value_irq, value_thread, value_user);
>  	if (err)
>  		return err;
>  	for (i = 0; i < data->nr_cpus; i++) {
> @@ -207,8 +206,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
>  	}
>  
>  	err = timerlat_bpf_get_summary_value(SUMMARY_COUNT,
> -					     value_irq, value_thread, value_user,
> -					     data->nr_cpus);
> +					     value_irq, value_thread, value_user);
>  	if (err)
>  		return err;
>  	for (i = 0; i < data->nr_cpus; i++) {
> @@ -218,8 +216,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
>  	}
>  
>  	err = timerlat_bpf_get_summary_value(SUMMARY_MIN,
> -					     value_irq, value_thread, value_user,
> -					     data->nr_cpus);
> +					     value_irq, value_thread, value_user);
>  	if (err)
>  		return err;
>  	for (i = 0; i < data->nr_cpus; i++) {
> @@ -229,8 +226,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
>  	}
>  
>  	err = timerlat_bpf_get_summary_value(SUMMARY_MAX,
> -					     value_irq, value_thread, value_user,
> -					     data->nr_cpus);
> +					     value_irq, value_thread, value_user);
>  	if (err)
>  		return err;
>  	for (i = 0; i < data->nr_cpus; i++) {
> @@ -240,8 +236,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
>  	}
>  
>  	err = timerlat_bpf_get_summary_value(SUMMARY_SUM,
> -					     value_irq, value_thread, value_user,
> -					     data->nr_cpus);
> +					     value_irq, value_thread, value_user);
>  	if (err)
>  		return err;
>  	for (i = 0; i < data->nr_cpus; i++) {
> @@ -782,7 +777,7 @@ static struct osnoise_tool
>  	if (!top)
>  		return NULL;
>  
> -	top->data = timerlat_alloc_top(nr_cpus);
> +	top->data = timerlat_alloc_top();
>  	if (!top->data)
>  		goto out_err;
>  
> diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src/timerlat_u.c
> index a569fe7f93aa..03b4e68e8b1e 100644
> --- a/tools/tracing/rtla/src/timerlat_u.c
> +++ b/tools/tracing/rtla/src/timerlat_u.c
> @@ -99,7 +99,7 @@ static int timerlat_u_main(int cpu, struct timerlat_u_params *params)
>   *
>   * Return the number of processes that received the kill.
>   */
> -static int timerlat_u_send_kill(pid_t *procs, int nr_cpus)
> +static int timerlat_u_send_kill(pid_t *procs)
>  {
>  	int killed = 0;
>  	int i, retval;
> @@ -169,7 +169,7 @@ void *timerlat_u_dispatcher(void *data)
>  
>  		/* parent */
>  		if (pid == -1) {
> -			timerlat_u_send_kill(procs, nr_cpus);
> +			timerlat_u_send_kill(procs);
>  			debug_msg("Failed to create child processes");
>  			pthread_exit(&retval);
>  		}
> @@ -196,7 +196,7 @@ void *timerlat_u_dispatcher(void *data)
>  		sleep(1);
>  	}
>  
> -	timerlat_u_send_kill(procs, nr_cpus);
> +	timerlat_u_send_kill(procs);
>  
>  	while (procs_count) {
>  		pid = waitpid(-1, &wstatus, 0);
> -- 
> 2.52.0
> 

