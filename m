Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572D84CF468
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 23:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792279551; cv=none; b=nEqvO0rBjeRL8T2axzDSr95Hzu3CY0z/UN/+bTLuNcNd0kPd5EgQeQH5LxnDQfXwkmnF6+LPiHTKUrISyzqKFyDuZcRkjEeJW+qt9Zx2ndk8/ykpidxAwxL7NjK7sh1GNOc2XxxUeu+0IHIN1zqIHNkbZShGg+sQ4DE+xU3/HAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792279551; c=relaxed/simple;
	bh=76+A5Jj0Hlrf12TczBu4HUo2tmyicY+Onp4kmxXjTS4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=uSoTLa5JYJyyBJswvQcUilkQ45krSZlY0qhvGDxfdPGmUeqF4dPTlIdfBqXhdvQCWPconEIPz0awZVxxIDMRwlVS3u+A7A0uDp6gEggkXGRr/0HH0HJbOcvzRKGMUiiPPnQMhI/xA41HdEue/HUdpVfsypqCie3wTLtM7I0cjsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvnA718d; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvnA718d"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso4468995ad.3
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792279550; x=1792884350; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=76+A5Jj0Hlrf12TczBu4HUo2tmyicY+Onp4kmxXjTS4=;
        b=PvnA718dzQSvfwkiDZjhzgwLANqqLbdoUPGy9N21Kzk6M2oSbtE//CVIdcbO2jsFfC
         nXKu9lqnL4KqfRB4mxYVN5O2RssqWQgy6x4CdSf3+qPlRKPIRaTMciUnph/hmkob3b20
         LGFYZ3mgIBOXmRkKkUhfWxq9+hU2VLpbwMMHGbUzNxCDerur8U8ChNW5eF8v4fjDcuTG
         dolkhC12W/5n3g+ZXW9zajfq28vtCvJJ6359jSfU4EHR0NcJCXwIqJ4Ld9KHjppwMFnN
         OPP+55gJBH6j7ipnjoLqJ1SvuxytuavAV9dvcFy+OGMF1rc2KdGO6t9qDxlZRsuPgr4l
         emGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792279550; x=1792884350;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=76+A5Jj0Hlrf12TczBu4HUo2tmyicY+Onp4kmxXjTS4=;
        b=pTAiI/4tcOp5YDcGFJs8Y+wI8PgTY5sWAx39BWLvqrumNT5x7iujMzdLbthIsQ0/AI
         8yWX/DkQJm45MwbRciUUSI4XEW+u2dpXoIRL+hWA17OgJjFfeMsEL/5Ye3JLHe/Wjo1C
         wYszLGmT3FAhUe2OiERX8fdVRSlbnMZJPlz79axT2kQb3lmQ8S+dz6w4j3llSeT+PKCD
         iBOOG9X2IRNLcMvnr0P2k+edstrfoZg7Kdt9Gmbi9ixzQPwnSrNx28yoMnOtx2cbLMu2
         ZdVlBm6YqNEClXzsLQeFRQDbR7KfNfFvitUcRE6YAzMdUqEJNHRpYd7uTpRr63TQVI4s
         39oQ==
X-Forwarded-Encrypted: i=1; AKwUvByaMXbEEjwwD36i1yY/d8UQaAiLL4jgA8/aftmZKg52w7/F8Kfi+S+RDVOgPMTsujLpWYk=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5uyAC9WI7W+LETB2yhTpFP4pGHFoK7y4vRrDEtiv1MV9vE4MT
	2jZhndrqPCK8Qdtse1X4pNkGgU5I1X5BfLoaWiB9qzB5je6caJaAvJO5
X-Gm-Gg: AYBFou11L2uDzxZneAwcINDa/UxYbgXASgW4VPYjCr+yQhmAuJo3NPdfC4dLAgSVwt9
	tyXKmPh5kan1fgJY3rMA8f2/DQmw1h94a0kb4JRw58TscVE6O0gBBoavR5r+QshWK2NY3vcRqu+
	tPXzB7Hn/XXt5n73hqxZllY8A2/8rG0dszpGUdTBYMsVVVOetxxwqXsWehub/JYndbTi0M3Lsbx
	FFm7Dz0KWcKoN7ggqb/k3AUrfdqfqmMGUt1wtMCt7Gt4B4LMkfqkpmmF08y29lNM9xVX/nQHZPe
	1rYY942Jt5llTGdihYRcl9QqgjxwisjgUZbc7FpUrzixIcTQPa77G+sIycBll5MwRlJuCTpnn7g
	S8KbO3JdyzJlYJpzyrxBr32rPiH1PUK2buufA6uVT9PE3EhQhUR8JuqJeLvzZ0JzuqP3fDYdONk
	7esCkGAiFEBnp5Q+vodH663l8HzFdxFfXxa/K09QC6vJGMFZOM3E1JjJ9dI04TfXZ1t4PWrPGSm
	Rpej3Yqlg+bb4vpIA7L7AqIcL2BXS3f99UZ89DcBYvJxsg4Nlf6/7hXaY+jPUvYBkzOyAbPC/UN
	dMM=
X-Received: by 2002:a17:903:24b:b0:2e5:41dc:9ac7 with SMTP id d9443c01a7336-2e9a6d252a3mr32793975ad.24.1792279549582;
        Sat, 17 Oct 2026 16:25:49 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e87994bsm24216375ad.60.2026.10.17.16.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 16:25:48 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Oct 2026 23:25:48 +0000
Message-Id: <DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com>
Cc: "Nam Cao" <namcao@linutronix.de>, "Wen Yang" <wen.yang@linux.dev>,
 "Tobias Schaffner" <tobias.schaffner@siemens.com>, "Viktor Malik"
 <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "John Ogness" <john.ogness@linutronix.de>, "Gabriele Monaco"
 <gmonaco@redhat.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>
In-Reply-To: <87v770uuyr.fsf@jogness.linutronix.de>
References: <20261001152042.124445-1-gmonaco@redhat.com> <20261001152042.124445-11-gmonaco@redhat.com> <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com> <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com> <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com> <878q3xtptq.fsf@jogness.linutronix.de> <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com> <87bj8s8ih9.fsf@jogness.linutronix.de> <DM78SVMBI2XW.2XHVC67VON48A@gmail.com> <87v770uuyr.fsf@jogness.linutronix.de>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Oct 17, 2026 at 07:02 PM John Ogness <john.ogness@linutronix.de> wrote:
> It would be nice if it could be filtered so that only RV violation
> bpf_printk's would trigger. I do not think it is possible for a filter
> to do primitive pattern matching on @bpf_string. Or am I wrong?

not an ftrace expert, but it should be possible. bpf_string is
a dynamic string field and filters take globs on those.

> With the "new" ringbuffer and nbcon implementations, it no longer dos-es
> the kernel, so I have no problem with bpf programs calling
> printk_deferred(). And besides, userspace can already blast the
> ringbuffer and consoles via /dev/kmsg.

well, /dev/kmsg is ratelimited unless printk.devkmsg=on,
but the kfunc wouldn't be.
I still feel that bpf_stream + user space that writes into
/dev/kmsg is a better design.
