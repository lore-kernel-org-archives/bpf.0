Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7BB58FD2D
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655990; cv=none; b=Q0KlXeb4gjlrJ+fLKex8x/NFxDo7oMQl4IrF9jjicqV5Io3QlDpCYH+Zc7eFfPCU3fDWbSSDnMbTJVjOr+s8d9ojnimqeh4kUkrFIWjmITjBRr3D01kNFk+ZVLypd/ZrTcQ1fxm7ZcXkWMebAn/XTHJvsvb1fKgVPOegsRc+FMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655990; c=relaxed/simple;
	bh=ypS+0W1JTkbNyjduQvRz5CNjg+2J9njr9YBCbuNjZKM=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=dR2p9jo3Kcq4NMN0AIovf7FSIexLKHLW9IxEaibDRd6tvoabqe0IPXclwykW+lhoFvt7D2WrW/Nr70bAFXD6dBEUYlmUKfk3z3pYCjTuqllZLHnPJ9DwzXWiI/Db11BKFVmXtwnK03Av9+7Hav6MICjuJOvljK+37I/aVNBdPQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNjTvLJB; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNjTvLJB"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb796so143348566b.2
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 07:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789655977; x=1790260777; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ypS+0W1JTkbNyjduQvRz5CNjg+2J9njr9YBCbuNjZKM=;
        b=NNjTvLJBMBhPIfXYKjyssqB0qPFs8d7YYTqVQtZcRnyhOL4jqg0IkM/zt3VVubhFGl
         x5eptrqYQhDblFRKdxpoFGXgAsJ4pYtNrt5VFRHc6C0ZZ9Wq0fbdHAxi2+2ifmodM0eq
         zlMFlIrP/d5TX6wUbAhEZ7xg9H9DxYMEe/zzOKjQfdS6C3wURZ5RtMGllGoIx/2fh5Uk
         Sq8Z7tkncPnWXbiWYF09odhjL2wyENXuEsJLgbWX9tDhxiF3PS84Mhh15ugq2CgqTnXO
         Faagn+0Y7wXn6nxTa4hRp7h8zmmWN/RuGmmrLEjhhfz0OF4J/gQoJw/0fk8IVYoAQ8PS
         OO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789655977; x=1790260777;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ypS+0W1JTkbNyjduQvRz5CNjg+2J9njr9YBCbuNjZKM=;
        b=gyKDEfILrkdqwKYCDg5pP87JBnOY6E3zYVvzHkzD+86w5Ut1UV4kwypmwfluEqql4k
         VzMDYBt4jvIr8ymwxwrWCkzcKh9x+oF8FgYw+5gcIF7RwAEKWwB6cH9jH8p6cAMBLDlE
         dnKO2veENvhumYQ0uMlDnWBfuc73X1SIv9GId9/qOB/IHlpxPEvsRGnm5K38+ii1/bK8
         wJ5UftA2cz9g8caAYP4ueohpsuvxQSqrCNEZ4hOoxs/Dq0YW7Y0kfZuc0K47NuANMS12
         ZCXFa6pv+6VJENO6mnqKOZT1cbRTdQKU0cTwBAxZhhgPwM+g7T/5rvNranRUnR1xNULA
         X1Pg==
X-Gm-Message-State: AFuF++kusVekLp8Yy18Rc40sd93m7R5pXWSxmUMnxzKJwl8Zy9EDUtdN
	xZS87agGXzvY+yValETCmmRwhSZT9bMN2klF0KUbKviUELuPAiFpFlKR
X-Gm-Gg: AYBFou0EvxZjlwAIYQ6bMA4NAlp6MStDGZeID6+45a9YxK12OOz/l6vYHxfTMBV0tr1
	eGxaVjzKDbkR9rO8ad+AuDARO2JOCyA38Mew5PC2/EUFTgFWb+HyRijhcaeR/1u/iqzyeYPplsD
	dZrm+jkT34ssT4TShmkUxGlVmvbd966Kxb/6gPtsfifJWo+MBYW2WCBmH/HsQbgOQ3zjhH6NNld
	CHbamhE5ee0oRVy2O/LA/+WlV0HjqEim4ziy02QpZ78ZwW48idO0ixI5ffB6/WVQ1t+J+VtEsPb
	0hno8n9KjS4/UWsRwX2qZKcqN3uS8UZJ91Iq29cB9HvIVMPao8IOhJ+knJy3X+zCLfUSD7fP14z
	d7joOB68tk/m4jW8EmWnznLNWoffLFQI76IZvSnSHXiUWqXTkibT6X9wOPFu2bD/0UotwZcgN13
	UytLSC4z76fiZ7jN6zDu10EEUZyTB/DAIw8dQO0ibXXQyJtitisAJoJ8orWbk+cJtVlRHdjgWmx
	+Qf+64RVfW+F/Hxc1BAHRCa3E5rBTtEaTTWz86vIrIlVRwDR4SQSCaaEWxnIcbBHGD7sMCp9jZm
	Dl2E
X-Received: by 2002:a17:907:9720:b0:c29:5215:b2d2 with SMTP id a640c23a62f3a-c29e52cddedmr517557966b.23.1789655977192;
        Thu, 17 Sep 2026 07:39:37 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de0898bdsm306916866b.5.2026.09.17.07.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 07:39:36 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 14:39:31 +0000
Message-Id: <DLHO3FH8LYMR.33VPRQKV0T0TU@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yun Lu" <luyun_611@163.com>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <ihor.solodrai@linux.dev>, <daniel@iogearbox.net>, <memxor@gmail.com>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <shuah@kernel.org>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf 1/2] selftests/bpf: Fix timing-dependent assertions
 in task work stress test
In-Reply-To: <20260917080839.462038-2-luyun_611@163.com>
References: <20260917080839.462038-1-luyun_611@163.com> <20260917080839.462038-2-luyun_611@163.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 17, 2026 at 04:08 PM Yun Lu <luyun_611@163.com> wrote:
> From: Yun Lu <luyun@kylinos.cn>
>
> task_work_run() assumes every stress run observes both scheduler
> contention and, when the delete thread is enabled, cancellation of at
> least one pending callback.
>
> Neither outcome is guaranteed. Contention is observed only when another
> scheduler selects the same one of 128 map values while its task work is
> outstanding. A valid run can therefore have no scheduling errors. This
> was reproduced with a single scheduler: more than one million callbacks
> were scheduled and completed while schedule_error remained zero.

So it was "reproduced" by changing nthreads from 16 to 1 ?
That's not a fix. With 16 threads hammering 128 entries for a second
schedule_error > 0 and callback_success < callback_scheduled are the
point of the test. They check that the -EBUSY path in
bpf_task_work_acquire_ctx() and the cancel path in
bpf_task_work_cancel_and_free() were actual
ly exercised. Without them
the stress test only checks that nothing crashed.
If the unmodified test fails somewhere, show the log.

Patch 2 is fine on its own. Send it alone against bpf-next.

pw-bot: cr
