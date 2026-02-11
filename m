Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81B824E4A1
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770807796; cv=none; b=raQcPmWdpfU64hAkN2FW8tWWWRoDAnXW3F+AaD9UwzXmwS6q2qsDuPHXO1LJKBLrBikTgYz7YDci+nERMC0Adgyum1O39WaDuDi2Wepp6qFS3oXgtw/6UAbhExiOba/QCurb/y+h9Wzgm2mP7PuOUsGyLAhWayXYuD4tyZOQUcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770807796; c=relaxed/simple;
	bh=mk/tFu2xb3TJ7XbF+LsRTR3t68f9Cb2gfi/rVMi3hgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3a6mjXupzpTl4SLoiy4Km2yeqFPpE784O6Ul/KOclGjY+ttW060S6pPrvo9RCD3Wtb5YSUhewN6A2PWr6nHSCYj/PUhdH02/KdN5pHQq2SeiblqhrowH/pN+J2FkmNeouxwSDavaEMs2VxM7N5WhldywnxfIVwuljg1HJ0Yhqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxZ/ZYtB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxZ/ZYtB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770807794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=97YY0+mUrinSZBPdrWpZVZPTzLm6/d/OwSRk4/dZKTI=;
	b=dxZ/ZYtBQE99sAHTHw5Ry3xQ6YbKBrRorPPyHfNKujEjzEixRQjcO0SPoc2ctGdjlniXOG
	94GMFT07d/1AycdffZcb1tMxT5PDhwE3q0KAKHXQ2hYsHNKhAMpJxuLmK3Gaa/i4lci32N
	AGfCy5Sf+yWi8MbiGrEtwawLeQPDQRw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-8UP_9t1sMmK_sM-2KGuhiw-1; Wed,
 11 Feb 2026 06:03:10 -0500
X-MC-Unique: 8UP_9t1sMmK_sM-2KGuhiw-1
X-Mimecast-MFC-AGG-ID: 8UP_9t1sMmK_sM-2KGuhiw_1770807787
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0697A18005B0;
	Wed, 11 Feb 2026 11:03:07 +0000 (UTC)
Received: from fedora (unknown [10.22.88.75])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5EB4730001A8;
	Wed, 11 Feb 2026 11:03:01 +0000 (UTC)
Date: Wed, 11 Feb 2026 08:03:00 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Tomas Glozar <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, John Kacur <jkacur@redhat.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tools/rtla: Consolidate nr_cpus usage across all
 tools
Message-ID: <aYxhtrJ8cw7SNOJy@fedora>
References: <20260209092436.2899888-1-costa.shul@redhat.com>
 <20260209092436.2899888-2-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209092436.2899888-2-costa.shul@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Feb 09, 2026 at 11:24:33AM +0200, Costa Shulyupin wrote:
> sysconf(_SC_NPROCESSORS_CONF) (via get_nprocs_conf) reflects
> cpu_possible_mask, which is fixed at boot time, so querying it
> repeatedly is unnecessary.
> 
> Replace multiple calls to sysconf(_SC_NPROCESSORS_CONF) with a single
> global nr_cpus variable initialized once at startup.
> 
> `#pragma once` in timerlat_u.h is needed for pre-C23 compilers to avoid
> redefinition errors.

Isn't it necessary for C23 compilers?

> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  tools/tracing/rtla/src/common.c        |  7 +++++--
>  tools/tracing/rtla/src/common.h        |  2 ++
>  tools/tracing/rtla/src/osnoise_hist.c  |  3 ---
>  tools/tracing/rtla/src/osnoise_top.c   |  7 -------
>  tools/tracing/rtla/src/timerlat.c      |  5 +----
>  tools/tracing/rtla/src/timerlat_aa.c   |  1 -
>  tools/tracing/rtla/src/timerlat_hist.c |  3 ---
>  tools/tracing/rtla/src/timerlat_top.c  |  7 -------
>  tools/tracing/rtla/src/timerlat_u.c    |  3 +--
>  tools/tracing/rtla/src/timerlat_u.h    |  1 +
>  tools/tracing/rtla/src/utils.c         | 10 +---------
>  11 files changed, 11 insertions(+), 38 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
> index ceff76a62a30..e4cf30a65e82 100644
> --- a/tools/tracing/rtla/src/common.c
> +++ b/tools/tracing/rtla/src/common.c
> @@ -5,12 +5,14 @@
>  #include <signal.h>
>  #include <stdlib.h>
>  #include <string.h>
> -#include <unistd.h>
>  #include <getopt.h>
> +#include <sys/sysinfo.h>
> +
>  #include "common.h"
>  
>  struct trace_instance *trace_inst;
>  volatile int stop_tracing;
> +int nr_cpus;
>  
>  static void stop_trace(int sig)
>  {
> @@ -135,7 +137,7 @@ common_apply_config(struct osnoise_tool *tool, struct common_params *params)
>  	}
>  
>  	if (!params->cpus) {
> -		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++)
> +		for (i = 0; i < nr_cpus; i++)
>  			CPU_SET(i, &params->monitored_cpus);
>  	}
>  
> @@ -183,6 +185,7 @@ int run_tool(struct tool_ops *ops, int argc, char *argv[])
>  	bool stopped;
>  	int retval;
>  
> +	nr_cpus = get_nprocs_conf();
>  	params = ops->parse_args(argc, argv);
>  	if (!params)
>  		exit(1);
> diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
> index 7602c5593ef5..32f9c1351209 100644
> --- a/tools/tracing/rtla/src/common.h
> +++ b/tools/tracing/rtla/src/common.h
> @@ -107,6 +107,8 @@ struct common_params {
>  	struct timerlat_u_params user;
>  };
>  
> +extern int nr_cpus;
> +
>  #define for_each_monitored_cpu(cpu, nr_cpus, common) \
>  	for (cpu = 0; cpu < nr_cpus; cpu++) \
>  		if (!(common)->cpus || CPU_ISSET(cpu, &(common)->monitored_cpus))
> diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
> index 9d70ea34807f..03ebff34fff4 100644
> --- a/tools/tracing/rtla/src/osnoise_hist.c
> +++ b/tools/tracing/rtla/src/osnoise_hist.c
> @@ -647,9 +647,6 @@ static struct osnoise_tool
>  *osnoise_init_hist(struct common_params *params)
>  {
>  	struct osnoise_tool *tool;
> -	int nr_cpus;
> -
> -	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
>  
>  	tool = osnoise_init_tool("osnoise_hist");
>  	if (!tool)
> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
> index d54d47947fb4..7dcd2e318205 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
> @@ -232,12 +232,8 @@ osnoise_print_stats(struct osnoise_tool *top)
>  {
>  	struct osnoise_params *params = to_osnoise_params(top->params);
>  	struct trace_instance *trace = &top->trace;
> -	static int nr_cpus = -1;
>  	int i;
>  
> -	if (nr_cpus == -1)
> -		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
> -
>  	if (!params->common.quiet)
>  		clear_terminal(trace->seq);
>  
> @@ -495,9 +491,6 @@ osnoise_top_apply_config(struct osnoise_tool *tool)
>  struct osnoise_tool *osnoise_init_top(struct common_params *params)
>  {
>  	struct osnoise_tool *tool;
> -	int nr_cpus;
> -
> -	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
>  
>  	tool = osnoise_init_tool("osnoise_top");
>  	if (!tool)
> diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
> index 8f8811f7a13b..69856f677fce 100644
> --- a/tools/tracing/rtla/src/timerlat.c
> +++ b/tools/tracing/rtla/src/timerlat.c
> @@ -99,7 +99,7 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
>  int timerlat_enable(struct osnoise_tool *tool)
>  {
>  	struct timerlat_params *params = to_timerlat_params(tool->params);
> -	int retval, nr_cpus, i;
> +	int retval, i;
>  
>  	if (params->dma_latency >= 0) {
>  		dma_latency_fd = set_cpu_dma_latency(params->dma_latency);
> @@ -115,8 +115,6 @@ int timerlat_enable(struct osnoise_tool *tool)
>  			return -1;
>  		}
>  
> -		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
> -
>  		for_each_monitored_cpu(i, nr_cpus, &params->common) {
>  			if (save_cpu_idle_disable_state(i) < 0) {
>  				err_msg("Could not save cpu idle state.\n");
> @@ -214,7 +212,6 @@ void timerlat_analyze(struct osnoise_tool *tool, bool stopped)
>  void timerlat_free(struct osnoise_tool *tool)
>  {
>  	struct timerlat_params *params = to_timerlat_params(tool->params);
> -	int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
>  	int i;
>  
>  	timerlat_aa_destroy();
> diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
> index 31e66ea2b144..5766d58709eb 100644
> --- a/tools/tracing/rtla/src/timerlat_aa.c
> +++ b/tools/tracing/rtla/src/timerlat_aa.c
> @@ -1022,7 +1022,6 @@ void timerlat_aa_destroy(void)
>   */
>  int timerlat_aa_init(struct osnoise_tool *tool, int dump_tasks)
>  {
> -	int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
>  	struct timerlat_aa_context *taa_ctx;
>  	int retval;
>  
> diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
> index 4e8c38a61197..841118ed84f2 100644
> --- a/tools/tracing/rtla/src/timerlat_hist.c
> +++ b/tools/tracing/rtla/src/timerlat_hist.c
> @@ -1031,9 +1031,6 @@ static struct osnoise_tool
>  *timerlat_init_hist(struct common_params *params)
>  {
>  	struct osnoise_tool *tool;
> -	int nr_cpus;
> -
> -	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
>  
>  	tool = osnoise_init_tool("timerlat_hist");
>  	if (!tool)
> diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
> index 284b74773c2b..3e395ce4fa9f 100644
> --- a/tools/tracing/rtla/src/timerlat_top.c
> +++ b/tools/tracing/rtla/src/timerlat_top.c
> @@ -442,15 +442,11 @@ timerlat_print_stats(struct osnoise_tool *top)
>  	struct timerlat_params *params = to_timerlat_params(top->params);
>  	struct trace_instance *trace = &top->trace;
>  	struct timerlat_top_cpu summary;
> -	static int nr_cpus = -1;
>  	int i;
>  
>  	if (params->common.aa_only)
>  		return;
>  
> -	if (nr_cpus == -1)
> -		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
> -
>  	if (!params->common.quiet)
>  		clear_terminal(trace->seq);
>  
> @@ -781,9 +777,6 @@ static struct osnoise_tool
>  *timerlat_init_top(struct common_params *params)
>  {
>  	struct osnoise_tool *top;
> -	int nr_cpus;
> -
> -	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
>  
>  	top = osnoise_init_tool("timerlat_top");
>  	if (!top)
> diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src/timerlat_u.c
> index ce68e39d25fd..a569fe7f93aa 100644
> --- a/tools/tracing/rtla/src/timerlat_u.c
> +++ b/tools/tracing/rtla/src/timerlat_u.c
> @@ -16,7 +16,7 @@
>  #include <sys/wait.h>
>  #include <sys/prctl.h>
>  
> -#include "utils.h"
> +#include "common.h"
>  #include "timerlat_u.h"
>  
>  /*
> @@ -131,7 +131,6 @@ static int timerlat_u_send_kill(pid_t *procs, int nr_cpus)
>   */
>  void *timerlat_u_dispatcher(void *data)
>  {
> -	int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
>  	struct timerlat_u_params *params = data;
>  	char proc_name[128];
>  	int procs_count = 0;
> diff --git a/tools/tracing/rtla/src/timerlat_u.h b/tools/tracing/rtla/src/timerlat_u.h
> index 661511908957..a692331bd1c7 100644
> --- a/tools/tracing/rtla/src/timerlat_u.h
> +++ b/tools/tracing/rtla/src/timerlat_u.h
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#pragma once
>  /*
>   * Copyright (C) 2023 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
>   */
> diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
> index 0da3b2470c31..8cd1b374b035 100644
> --- a/tools/tracing/rtla/src/utils.c
> +++ b/tools/tracing/rtla/src/utils.c
> @@ -19,7 +19,7 @@
>  #include <stdio.h>
>  #include <limits.h>
>  
> -#include "utils.h"
> +#include "common.h"
>  
>  #define MAX_MSG_LENGTH	1024
>  int config_debug;
> @@ -119,14 +119,11 @@ int parse_cpu_set(char *cpu_list, cpu_set_t *set)
>  {
>  	const char *p;
>  	int end_cpu;
> -	int nr_cpus;
>  	int cpu;
>  	int i;
>  
>  	CPU_ZERO(set);
>  
> -	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
> -
>  	for (p = cpu_list; *p; ) {
>  		cpu = atoi(p);
>  		if (cpu < 0 || (!cpu && *p != '0') || cpu >= nr_cpus)
> @@ -559,7 +556,6 @@ int save_cpu_idle_disable_state(unsigned int cpu)
>  	unsigned int nr_states;
>  	unsigned int state;
>  	int disabled;
> -	int nr_cpus;
>  
>  	nr_states = cpuidle_state_count(cpu);
>  
> @@ -567,7 +563,6 @@ int save_cpu_idle_disable_state(unsigned int cpu)
>  		return 0;
>  
>  	if (saved_cpu_idle_disable_state == NULL) {
> -		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
>  		saved_cpu_idle_disable_state = calloc(nr_cpus, sizeof(unsigned int *));
>  		if (!saved_cpu_idle_disable_state)
>  			return -1;
> @@ -644,13 +639,10 @@ int restore_cpu_idle_disable_state(unsigned int cpu)
>  void free_cpu_idle_disable_states(void)
>  {
>  	int cpu;
> -	int nr_cpus;
>  
>  	if (!saved_cpu_idle_disable_state)
>  		return;
>  
> -	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
> -
>  	for (cpu = 0; cpu < nr_cpus; cpu++) {
>  		free(saved_cpu_idle_disable_state[cpu]);
>  		saved_cpu_idle_disable_state[cpu] = NULL;
> -- 
> 2.52.0
> 

