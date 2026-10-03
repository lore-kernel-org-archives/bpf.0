Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEE8429811
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791029956; cv=none; b=cfIjDCnwgspO6GVsMcH21yVPOA779J4kTH/4zQRyQfPPzogjuvzS3Ona4q9+C8OZKkuN+BzunpCKSkessEmqr3PQ6XMUgCsNeIlCjlq0mlH1VMFCcup3ido+LkUkjlfV1gebqYHCy9OJoftjvdIfTPfFbE0nu12KDaU+uRUEo9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791029956; c=relaxed/simple;
	bh=V0/7vUbzZ2WS3ekKYc+/9kx/XXTqOYvzaiHvHZHSBnk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=RV25jwZ8MukDlBu4pqnIBNV+tjRl/NjmZCsfByuKU1pv2salTu5hZiMhu5U3C1Q3BZiC3mlNwtTfIbC8XR5QiqSxLlhAjMO80vkQnHfxp4qC5H0QN/6u1o8pWjr9HGoycavlrc2RgduGbM7W6B7W5O77iFTv/+kiAIusI3q2eXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ya1uPvVe; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya1uPvVe"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc4dbcf2b85so192421a12.3
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791029944; x=1791634744; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V0/7vUbzZ2WS3ekKYc+/9kx/XXTqOYvzaiHvHZHSBnk=;
        b=Ya1uPvVeeM6n17IR0e8tR+Fjn4A7Tt8xHAj2K4RCLwhM/hfRH2CLdq5KVXsqQ+7+x3
         Bjh71FLm+eHABWYeuAqtB8u41rC6u3Gv0BBngTOtNGGVVoYenWZdoIx3EaA3DW/NqxEm
         r1BZUyVLORTMFFEYNnrQzZPkAX5SzAzBvz9lKEZ3dm47fm7OGnnuU6Pf8eBH/fTDejMv
         npC3Z2mnofQdhE53ZvxxScLXy/4abR1ig/Pap4sIskWXMbYdPYLxYYrtmb8UwcnIJNTw
         789AGnYTn0CFfvhsFtKtHWJVNh1VUA9JUAmfn7mEfHa9u0CqKMUz5YKq5/iDP7QXZpvj
         C1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791029944; x=1791634744;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V0/7vUbzZ2WS3ekKYc+/9kx/XXTqOYvzaiHvHZHSBnk=;
        b=tUlM/iRfIkSa3Gxs1e32aY1QY00JQp5gzPUSvDCj5BpIbdH2w3f2KyEdyKe/CjolL6
         aQTUzrO5kf6hGahFOsMPTBT6+rtm1R546fs+HWXf+6ow1GOa9fnjfpYMFwBiGb1MD8u8
         OpwdU6PeejAWFQWYNuX0/5QcXYk2zvi2A3YlRqr3ROv+2XY0XXDvIUcNuVBgTf9+pSh7
         GK6JTs61sLa3bE/dn4VXe0sm5zit0Q2Blk//5g9Z1xltuLD5xc3mZbN8Hw//RIq6aJsh
         54t8Mjx6upRLdUkzlc0OKgE8fT6WkstZ2sGfA55ksAXDs7B8dzY/jBV55uOK7RlVxSlf
         fEMQ==
X-Forwarded-Encrypted: i=1; AKwUvBx6hhGdUkW1/o5z/2Af8mr4aaYQFe6B3XBf2L554WXrxdvXHJIfkoKRaHgFP7GKrcU1pzc=@vger.kernel.org
X-Gm-Message-State: AFuF++nIz2mufiDA0hOwjuXr4lxB5ANLcISeyCBZWWm7Wkma6pkoFAyH
	urwZlURnEW8pYluqGkYG9PkxImzshd01VZfw3L+PH80EdYYM7uVUeN8f
X-Gm-Gg: AYBFou3ORtBMgJIZsyAz54hFk3FoZd4UhPwNuuwnZKOdfdsT0ZFswJcC7cYr8qtiXZ+
	ZcVY7sAPBhp2n4BEtEqMwlcjuYPbYFeydcQNhUN/XHAjISE6hNjoa3Bhx9935IZ2h31ccSJYqUr
	wRfnWT6KJkRGdO1SkG8Crknxmx7GmXuXKkBJ2nrH52V3JwE9toP3TDxhlrOqZ5mYMQt9zOew/iB
	zccf7L4aJEjCmeE4X7GvsNIkV6KDjBsB1wNy89FD7cELLdjeXDAWnnQIbWZY0F7e8yVXdsXOCOl
	l+F8oOkTTLu18RjALY878gJ+IbtkJn6TKDaEQ9OIwLBGscXtw+bdoWTgMGXTfi+eRGQnG7DhjOK
	vWD9a6gOcZ1kizzyzni7u2uLIQf3CXydqgZtVS0y1KEoW9JrXQvkCW3KMuIfkMmgYBTkqAp3Ewi
	gBarvbXBckZsoWtKlZeiS9iSrKakTP3Lad30fDHfDVD7s34GUaAtT98K9qQp2suTi994ZUgAaYQ
	MuRtPgYP9GnAwqAVkg8ZwRMdTpFojDSWZussQhJKZ3iSf3LIvdVMnN+U1AsAKclwtiYe74+Hpnh
	G9E=
X-Received: by 2002:a05:6a21:d89:b0:3dd:a197:7360 with SMTP id adf61e73a8af0-3e0d6d8ff80mr2052536637.57.1791029943830;
        Sat, 03 Oct 2026 05:19:03 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cca561e9d1dsm1740373a12.6.2026.10.03.05.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 05:19:03 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 12:19:02 +0000
Message-Id: <DLV74KRI1SBL.MYZVQAB3N6QG@gmail.com>
Cc: <abuehaze@amazon.com>, <acme@kernel.org>, <andrii@kernel.org>,
 <arighi@nvidia.com>, <arnd@arndb.de>, <bentiss@kernel.org>,
 <bpf@vger.kernel.org>, <changwoo@igalia.com>, <christian@heusel.eu>,
 <daniel@iogearbox.net>, <doebel@amazon.de>, <eddyz87@gmail.com>,
 <ihor.solodrai@linux.dev>, <irogers@google.com>,
 <jay.wang.upstream@gmail.com>, <jikos@kernel.org>, <jolsa@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <linux-perf-users@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux@weissschuh.net>, <martin.lau@linux.dev>,
 <mathieu.desnoyers@efficios.com>, <mcgrof@kernel.org>, <memxor@gmail.com>,
 <mhiramat@kernel.org>, <mpohlack@amazon.de>, <namhyung@kernel.org>,
 <nathan@kernel.org>, <nsc@kernel.org>, <ojeda@kernel.org>,
 <petr.pavlu@suse.com>, <qmo@kernel.org>, <rostedt@goodmis.org>,
 <rust-for-linux@vger.kernel.org>, <samitolvanen@google.com>,
 <sched-ext@lists.linux.dev>, <shuah@kernel.org>, <tj@kernel.org>,
 <void@manifault.com>, <wanjay@amazon.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 00/12] bpf: make the vmlinux BTF an
 on-demand loadable module (CONFIG_DEBUG_INFO_BTF=m) to save ~5.4 MB memory
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <alan.maguire@oracle.com>
In-Reply-To: <7fe71959-1c58-4b6f-9019-6f886683530e@oracle.com>
References: <DLUZVHOLSN1B.115EUX4KJBEA3@gmail.com> <7fe71959-1c58-4b6f-9019-6f886683530e@oracle.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Oct 03, 2026 at 12:45 PM Alan Maguire <alan.maguire@oracle.com> wrote:
> The only overall cost is if when we wind up using vmlinux BTF with the compressed
> .BTF section, since we have to do a full vmlinux BTF allocation (on top of the
> spac taken up by the compressed .BTF section) right? So slight penalty if vmlinux
> is used, but big gain if not.

I think it can be copied compressed into vmalloc area and
freed after decompress, so memory usage should be exactly the same.
