Return-Path: <SRS0=j30r=B4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C680DC433DF
	for <bpf@archiver.kernel.org>; Tue, 18 Aug 2020 12:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8564820706
	for <bpf@archiver.kernel.org>; Tue, 18 Aug 2020 12:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgHRM61 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:58:27 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:33854 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgHRM60 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Aug 2020 08:58:26 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k81C3-002tmZ-LA; Tue, 18 Aug 2020 06:58:23 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k81C2-000283-Se; Tue, 18 Aug 2020 06:58:23 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        linux-fsdevel@vger.kernel.org, criu@openvz.org,
        bpf@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>
References: <20200817220425.9389-11-ebiederm@xmission.com>
        <202008181316.x96Qp7qo%lkp@intel.com>
Date:   Tue, 18 Aug 2020 07:54:50 -0500
In-Reply-To: <202008181316.x96Qp7qo%lkp@intel.com> (kernel test robot's
        message of "Tue, 18 Aug 2020 13:39:44 +0800")
Message-ID: <87364k3yhx.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k81C2-000283-Se;;;mid=<87364k3yhx.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX199+9M7+Xk2NQhTl3vv/R8uMu696mUUptA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 11/17] bpf/task_iter: In task_file_seq_get_next use fnext_task
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> Hi "Eric,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on bpf/master]
> [also build test WARNING on linus/master v5.9-rc1 next-20200817]
> [cannot apply to bpf-next/master linux/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Eric-W-Biederman/exec-Move-unshare_files-to-fix-posix-file-locking-during-exec/20200818-061552
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
> config: i386-randconfig-m021-20200818 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> smatch warnings:
> kernel/bpf/task_iter.c:162 task_file_seq_get_next() warn: ignoring unreachable code.

What is smatch warning about?

Perhaps I am blind but I don't see any unreachable code there.

Doh!  I see it.  That loop will never loop so curr_fd++ is unreachable.
Yes that should get fixed just so the code is readable.

I will change that.

Eric


>    128	
>    129	static struct file *
>    130	task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info,
>    131			       struct task_struct **task)
>    132	{
>    133		struct pid_namespace *ns = info->common.ns;
>    134		u32 curr_tid = info->tid;
>    135		struct task_struct *curr_task;
>    136		unsigned int curr_fd = info->fd;
>    137	
>    138		/* If this function returns a non-NULL file object,
>    139		 * it held a reference to the task/file.
>    140		 * Otherwise, it does not hold any reference.
>    141		 */
>    142	again:
>    143		if (*task) {
>    144			curr_task = *task;
>    145			curr_fd = info->fd;
>    146		} else {
>    147			curr_task = task_seq_get_next(ns, &curr_tid);
>    148			if (!curr_task)
>    149				return NULL;
>    150	
>    151			/* set *task and info->tid */
>    152			*task = curr_task;
>    153			if (curr_tid == info->tid) {
>    154				curr_fd = info->fd;
>    155			} else {
>    156				info->tid = curr_tid;
>    157				curr_fd = 0;
>    158			}
>    159		}
>    160	
>    161		rcu_read_lock();
>  > 162		for (;; curr_fd++) {
>    163			struct file *f;
>    164	
>    165			f = fnext_task(curr_task, &curr_fd);
>    166			if (!f)
>    167				break;
>    168	
>    169			/* set info->fd */
>    170			info->fd = curr_fd;
>    171			get_file(f);
>    172			rcu_read_unlock();
>    173			return f;
>    174		}
>    175	
>    176		/* the current task is done, go to the next task */
>    177		rcu_read_unlock();
>    178		put_task_struct(curr_task);
>    179		*task = NULL;
>    180		info->fd = 0;
>    181		curr_tid = ++(info->tid);
>    182		goto again;
>    183	}
>    184	
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
