Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF581480963
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930556; cv=none; b=j9Av7a2TYqedWBFjD0PDEJMY8lMXMr6dDi3dmHWTGCdxJYZTAWUqefkJhJz385GPDdPbrh1WR+SBSAzUnevIP6O9rMO3BUurtIS68H+C+pySRuT+zvMrU8v6ecYzeLhJ+X4HfhrqtufFCc9OITrqP7YukrqwoH9MjcCuD47YshQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930556; c=relaxed/simple;
	bh=VMNDqBp0Cy8XekWXaHAUNRcSL2ZLfh+2UMAq0xwoKaE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iT6RLGlZvf++QFShnjd8kB3MuLB5PdLG8znic9dCEJnx/5RyRi5NngnePLEinGMz2nhpFMIkHcjiOFgeOJL2ekQ7uLR0T005n0VhXj3S7P49lfhrItlM0PbN/3f+0g80tL94k8LLw1XZud+h2qRDAVyvBSKWqEY8W4M8lLUKjpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIyt4It/; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIyt4It/"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8cceb2ecc03so38069346d6.3
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 07:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780930549; x=1781535349; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vU8Tk4A4RjDYcT3OUJAeuDXG3Ce7DLThoR+CZQwpZiE=;
        b=HIyt4It/b0CwC+GpaLocy1srnkcMtiQt6PQvY2ANndnlGQ8tHnaB/FjiUUch6CDwg/
         jFG9zs+gFDHxjsP9cNr84o/NO1V6PbmqxMbRDhC5CgJaQ1VJsJ2XaofMq/7BOARTZ9Nb
         Zi8IFdObngG6S0W7e+2SvwWCRn3PVX6fIHA/7xRRNtwQv9SVdSU2v/NTznLQhBBz9YBp
         SuKYBnFy9iM9nSEvUentenszwlS3U+wQ3d+MdyBhSAQiE1szMTFy9Chmf3XvOGT8d53h
         ugmXEeNLtS9T9cMseRn26ooF6c+Alh6+UmRMzkcmbM/DVjVU+SqNdl8+MlEP2pMDkJYm
         Gx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780930549; x=1781535349;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vU8Tk4A4RjDYcT3OUJAeuDXG3Ce7DLThoR+CZQwpZiE=;
        b=MmsQ8Cn68POXf/6DhPe1RdbRug6YeD7Y+iDscvy81QyLwq8a09IFwtICrnOCXvuf6F
         kFEl0hYWp2X8AaL5XQTe1A1BdM3BMVHXoxgVNVJEDfOHtgGaX+Y6EbwPTEY2ucmBLfB7
         rgjPb6HvyYq8GiK2Vd7RVn0kA23y5epUAWsVulXX/DoZxW7S96QQ3rC2mnZCs/YUtQ1G
         i9DEIrTQf3SpUikcU95DI7edXwmF/osgpQ7UDnlI8uaPJrAdz3OV8dfMTjO/Z2AmrHmQ
         Fqhdgea2YNLYgAWhGUJ0LjKkb9esgIfpJ4o882R+MpYw8ygqGqbUqOglfcch6UOIbq4A
         z8Ng==
X-Gm-Message-State: AOJu0YxkK7TtOClCdwPL0BZ5MTgfs+3gdKRWvY28AZSlRC2a/5Xr5BYg
	bA5Cu9h9vIss/2ogE8mAWtZNSLFX47EcRwBmkFWMXpedWG/Gy4fpTtXr
X-Gm-Gg: Acq92OHeh8UkTDohV8JX4IYfvod6pS9zFQTxGHSnmEuDE8S+ql2oFrFJxGx4i/jDPss
	na36qztyh81eH7qpJbtFVIhWY1Pusks/5reTMj4w7B5eui8AGNNeN1mMNT4qMNLg3zJY/nsZon6
	36OiPLdQbmwimegGpVE8uA8gK4xvL1tcBlTmV/DJGZCcT4JtpPQP7399spnSx6y/5hjlTxOB9j2
	sWHXkMELImDGg1yXHpd4PoXSuTuLaXAaiLpRs1K7tG2eIF8kOSFJJuHKZe4vYpEWCPubLfXjXHU
	nv7Kfl7qcx3k6ykzWDV73wFtOgeM4UUarPLOV9uKK1bYWUIcxCtd/pgR3GTc+EK3LSAX+EBswU1
	3ANvZYTyXbLh2IImXmyNOKZaCpJ0aYOPUVxkZzS1MnEfpHY5HUfg2zfj2KSTMoj53VwDRfc7Lun
	eodruT6hHhcWm/u+11QEqTEBG/b985
X-Received: by 2002:a0c:d809:0:b0:8ce:befc:dfe9 with SMTP id 6a1803df08f44-8cee6009304mr175142066d6.17.1780930548590;
        Mon, 08 Jun 2026 07:55:48 -0700 (PDT)
Received: from localhost ([43.225.189.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdcc968sm176992026d6.22.2026.06.08.07.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:55:47 -0700 (PDT)
Date: Mon, 8 Jun 2026 17:55:40 +0300
From: Dan Carpenter <error27@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
Subject: [bug report] bpf: Refactor object relationship tracking and fix
 dynptr UAF bug
Message-ID: <aibX7BzvtbZYoZcY@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Amery Hung,

Commit 308c7a0ae885 ("bpf: Refactor object relationship tracking and
fix dynptr UAF bug") from May 28, 2026 (linux-next), leads to the
following Smatch static checker warning:

	kernel/bpf/verifier.c:13115 check_kfunc_call()
	warn: error code type promoted to positive: 'id'

kernel/bpf/verifier.c
    12810 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
    12811                             int *insn_idx_p)
    12812 {
    12813         bool sleepable, rcu_lock, rcu_unlock, preempt_disable, preempt_enable;
    12814         struct bpf_reg_state *regs = cur_regs(env);
    12815         const char *func_name, *ptr_type_name;
    12816         const struct btf_type *t, *ptr_type;
    12817         struct bpf_kfunc_call_arg_meta meta;
    12818         struct bpf_insn_aux_data *insn_aux;
    12819         int err, insn_idx = *insn_idx_p;
    12820         u32 i, nargs, ptr_type_id, id;
                                             ^^
Originally id was int.  It needs to be int for the error handling to
work.

    12821         const struct btf_param *args;
    12822         struct btf *desc_btf;
    12823 
    12824         /* skip for now, but return error when we find this in fixup_kfunc_call */

[ snip ]

    13112                 mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
    13113                 if (is_kfunc_acquire(&meta)) {
    13114                         id = acquire_reference(env, insn_idx, 0);
--> 13115                         if (id < 0)
                                      ^^^^^^

    13116                                 return id;
    13117                         regs[BPF_REG_0].id = id;
    13118                 } else if (is_rbtree_node_type(ptr_type) || is_list_node_type(ptr_type)) {
    13119                         ref_set_non_owning(env, &regs[BPF_REG_0]);

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
